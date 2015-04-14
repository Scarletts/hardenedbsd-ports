# $FreeBSD$

PORTNAME=	secadm-devel
PORTVERSION=	0.2
PORTREVISION?=  2
CATEGORIES=	hardenedbsd

MAINTAINER=	shawn.webb@hardenedbsd.org
COMMENT=	HardenedBSD Security Administration

USES=		kmod
LIB_DEPENDS=	libucl.so:${PORTSDIR}/textproc/libucl

CONFLICTS_INSTALL=	secadm-[0-9a-f]*

USE_GITHUB=	yes
GH_ACCOUNT=	HardenedBSD
GH_PROJECT=	secadm
GH_COMMIT=	15201fe
GH_TAGNAME=	${GH_COMMIT}

LIBDIR?=	${PREFIX}/lib

MAKE_JOBS_UNSAFE=	yes

.include <bsd.port.mk>

