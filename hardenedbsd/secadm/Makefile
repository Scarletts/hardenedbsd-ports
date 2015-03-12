# $FreeBSD$

PORTNAME=	secadm
PORTVERSION=	0.2.c7f1b4f
CATEGORIES=	hardenedbsd

MAINTAINER=	shawn.webb@hardenedbsd.org
COMMENT=	HardenedBSD Security Administration

USES=	kmod
LIB_DEPENDS=	libucl.so:${PORTSDIR}/textproc/libucl

USE_GITHUB=	yes
GH_ACCOUNT=	HardenedBSD
GH_PROJECT=	secadm
GH_COMMIT=	c7f1b4f
GH_TAGNAME=	${GH_COMMIT}

LIBDIR?=	${PREFIX}/lib

MAKE_JOBS_UNSAFE=	yes

.include <bsd.port.mk>

