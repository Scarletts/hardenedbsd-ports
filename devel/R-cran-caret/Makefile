# Created by: TAKATSU Tomonari <tota@FreeBSD.org>
# $FreeBSD$

PORTNAME=	caret
DISTVERSION=	6.0-62
CATEGORIES=	devel
DISTNAME=	${PORTNAME}_${DISTVERSION}

MAINTAINER=	tota@FreeBSD.org
COMMENT=	Classification and Regression Training

LICENSE=	GPLv2 GPLv3
LICENSE_COMB=	dual

RUN_DEPENDS=	R-cran-ggplot2>0:${PORTSDIR}/graphics/R-cran-ggplot2 \
		R-cran-car>0:${PORTSDIR}/math/R-cran-car \
		R-cran-foreach>0:${PORTSDIR}/devel/R-cran-foreach \
		R-cran-plyr>0:${PORTSDIR}/devel/R-cran-plyr \
		R-cran-reshape2>0:${PORTSDIR}/devel/R-cran-reshape2

USES=	cran:auto-plist

.include <bsd.port.mk>
