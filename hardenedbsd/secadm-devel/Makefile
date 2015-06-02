# $FreeBSD$

PORTNAME=	secadm-devel
PORTVERSION=	0.2.2
PORTREVISION=	2
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
GH_COMMIT=	8adaf0a
GH_TAGNAME=	${GH_COMMIT}

.include <bsd.port.mk>

