#!/bin/sh

# Copyright (c) 2015 Franco Fichtner <franco@opnsense.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

set -e

if [ "$(id -u)" != "0" ]; then
	echo "Must be root."
	exit 1
fi

# clean up old stale working directories
rm -rf /tmp/opnsense-update.*

MARKER="/usr/local/opnsense/version/os-update"
ORIGIN="/usr/local/etc/pkg/repos/origin.conf"
MY_RELEASE="15.1-hbsd-exp-02"
MIRROR="http://hardenedbsd.org/opnsense-hbsd/distsets/${MY_RELEASE}"
ARCH=$(uname -m)

INSTALLED_BASE=
if [ -f ${MARKER}.base ]; then
	INSTALLED_BASE=$(cat ${MARKER}.base)
fi

INSTALLED_KERNEL=
if [ -f ${MARKER}.kernel ]; then
	INSTALLED_KERNEL=$(cat ${MARKER}.kernel)
fi

DO_RELEASE=
DO_FLAVOUR=
DO_MIRROR=
DO_KERNEL=
DO_FORCE=
DO_BASE=
DO_PKGS=

while getopts bcfkm:n:pr:v OPT; do
	case ${OPT} in
	b)
		DO_BASE="-b"
		;;
	c)
		# -c only ever checks the embedded version string
		if [ "${MY_RELEASE}-${ARCH}" = "${INSTALLED_KERNEL}" -a \
		    "${MY_RELEASE}-${ARCH}" = "${INSTALLED_BASE}" ]; then
			echo "Your system is up to date."
			exit 1
		fi
		echo "There are updates available."
		exit 0
		;;
	f)
		DO_FORCE="-f"
		;;
	k)
		DO_KERNEL="-k"
		;;
	m)
		DO_MIRROR="-m ${OPTARG}"
		MIRROR=${OPTARG}
		;;
	n)
		DO_FLAVOUR="-n ${OPTARG}"
		FLAVOUR=${OPTARG}
		;;
	p)
		DO_PKGS="-p"
		;;
	r)
		DO_RELEASE="-r ${OPTARG}"
		RELEASE=${OPTARG}
		;;
	v)
		echo ${MY_RELEASE}-${ARCH}
		exit 0
		;;
	*)
		echo "Usage: opnsense-update [-bcfkpv] [-m mirror] [-r release]" >&2
		exit 1
		;;
	esac
done

if [ -z "${DO_KERNEL}${DO_BASE}${DO_PKGS}" ]; then
	# default is enable all
	DO_KERNEL="-k"
	DO_BASE="-b"
	DO_PKGS="-p"
fi

if [ -n "${DO_FLAVOUR}" ]; then
	# replace the package repo name
	sed -i '' "/url:/s/\${ABI}.*/\${ABI}\/${FLAVOUR}\",/" ${ORIGIN}
fi

if [ -n "${DO_PKGS}" ]; then
	pkg update ${DO_FORCE}
	pkg upgrade -y ${DO_FORCE}
	pkg autoremove -y
	pkg clean -y
	if [ -n "${DO_BASE}${DO_KERNEL}" ]; then
		# script may have changed, relaunch...
		opnsense-update ${DO_BASE} ${DO_KERNEL} \
		    ${DO_FORCE} ${DO_RELEASE} ${DO_MIRROR}
	fi
	# stop here to prevent the second pass
	exit 0
fi

# if no release was selected we use the embedded defaults
if [ -z "${RELEASE}" ]; then
	RELEASE=${MY_RELEASE}

	if [ ${ARCH} = "amd64" ]; then
		OBSOLETESHA=""
		KERNELSHA="582b5f79be4f7d84bbe709a06f318b8f5678b885727239c5f73c97b060f0379f"
		BASESHA="463dbe6400787986f57772f7c84b7e19287b682f334e5acb06897999d6ba3c53"
	elif [ ${ARCH} = "i386" ]; then
		echo "OPNSense + HardenedBSD is currently only supported on amd64."
		exit 1
	else
		echo "Unknown architecture ${ARCH}" >&2
		exit 1
	fi
fi

if [ -z "${DO_FORCE}" ]; then
	# disable kernel update if up-to-date
	if [ "${RELEASE}-${ARCH}" = "${INSTALLED_KERNEL}" -a \
	    -n "${DO_KERNEL}" ]; then
		DO_KERNEL=
	fi

	# disable base update if up-to-date
	if [ "${RELEASE}-${ARCH}" = "${INSTALLED_BASE}" -a \
	    -n "${DO_BASE}" ]; then
		DO_BASE=
	fi

	# nothing to do
	if [ -z "${DO_KERNEL}${DO_BASE}" ]; then
		echo "Your system is up to date."
		exit 0
	fi
fi

echo "!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!"
echo "! A kernel/base upgrade is in progress. !"
echo "!  Please do not turn off the system.   !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

OBSOLETESET=
KERNELSET=kernel-${RELEASE}-${ARCH}.txz
BASESET=base-${RELEASE}-${ARCH}.txz
WORKDIR=/tmp/opnsense-update.${$}
KERNELDIR=/boot/kernel

fetch_set()
{
	echo -n "Fetching ${1}... "

	mkdir -p ${WORKDIR} && \
	    fetch -q ${MIRROR}/${1} -o ${WORKDIR}/${1} && \
	    [ -z "${2}" -o "`sha256 -q ${WORKDIR}/${1}`" = "${2}" ] && \
	    echo "ok" && return

	echo "failed"
	exit 1
}

apply_kernel()
{
	echo -n "Applying ${KERNELSET}... "

	rm -rf ${KERNELDIR}.old && \
	    mv ${KERNELDIR} ${KERNELDIR}.old && \
	    tar -C/ -xpf ${WORKDIR}/${KERNELSET} && \
	    kldxref ${KERNELDIR} && \
	    echo "ok" && return

	echo "failed"
	exit 1
}

apply_base()
{
	echo -n "Applying ${BASESET}... "

	# Ideally, we don't do any exlcude magic and simply
	# reapply all the packages on bootup and do another
	# reboot just to be safe...

	chflags -R noschg /bin /sbin /lib /libexec \
	    /usr/bin /usr/sbin /usr/lib && \
	    tar -C/ -xpf ${WORKDIR}/${BASESET} \
	    --exclude="./etc/group" \
	    --exclude="./etc/master.passwd" \
	    --exclude="./etc/passwd" \
	    --exclude="./etc/shells" \
	    --exclude="./etc/ttys" \
	    --exclude="./etc/rc" && \
	    kldxref ${KERNELDIR} && \
	    echo "ok" && return

	echo "failed"
	exit 1
}

apply_obsolete()
{
	echo -n "Applying ${OBSOLETESET}... "

	while read FILE; do
		rm -f ${FILE}
	done < ${WORKDIR}/${OBSOLETESET}

	echo "ok"
}

if [ -n "${DO_KERNEL}" ]; then
	fetch_set ${KERNELSET} ${KERNELSHA}
fi

if [ -n "${DO_BASE}" ]; then
	fetch_set ${BASESET} ${BASESHA}
	if [ -n "${OBSOLETESET}" ]; then
		fetch_set ${OBSOLETESET} ${OBSOLETESHA}
	fi
fi

if [ -n "${DO_KERNEL}" ]; then
	apply_kernel
fi

if [ -n "${DO_BASE}" ]; then
	apply_base
	if [ -n "${OBSOLETESET}" ]; then
		apply_obsolete
	fi
fi

# bootstrap the directory  if needed
mkdir -p $(dirname ${MARKER})
# remove the file previously used
rm -f ${MARKER}

if [ -n "${DO_KERNEL}" ]; then
	echo ${RELEASE}-${ARCH} > ${MARKER}.kernel
fi

if [ -n "${DO_BASE}" ]; then
	echo ${RELEASE}-${ARCH} > ${MARKER}.base
fi

rm -rf ${WORKDIR}

echo "Please reboot."
