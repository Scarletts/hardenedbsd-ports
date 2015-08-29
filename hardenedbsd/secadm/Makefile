# $FreeBSD$

PORTNAME=	secadm
PORTVERSION=	0.2.4
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
#GH_COMMIT=	ace6559
GH_TAGNAME=	v0.2.4

.include <bsd.port.mk>

