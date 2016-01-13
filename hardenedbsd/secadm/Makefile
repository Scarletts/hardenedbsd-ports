# $FreeBSD$

PORTNAME=	secadm
PORTVERSION=	0.3
PORTREVISION=	0
CATEGORIES=	hardenedbsd

MAINTAINER=	shawn.webb@hardenedbsd.org
COMMENT=	HardenedBSD Security Administration

USES=	kmod
LIB_DEPENDS=	libucl.so:${PORTSDIR}/textproc/libucl

LIBDIR?=	${PREFIX}/lib

MAKE_JOBS_UNSAFE=	yes

USE_GITHUB=	yes
GH_ACCOUNT=	HardenedBSD
GH_PROJECT=	secadm
GH_COMMIT=	3e3fe8c
GH_TAGNAME=	${GH_COMMIT}

.include <bsd.port.pre.mk>

.if ${OPSYS} == FreeBSD && ${OSVERSION} < 1100000
LIB_DEPENDS+=	libxo.so:${PORTSDIR}/devel/libxo
.endif

.include <bsd.port.mk>

