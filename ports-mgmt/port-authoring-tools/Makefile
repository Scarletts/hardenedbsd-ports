# $FreeBSD$

PORTNAME=	port-authoring-tools
PORTVERSION=	1.0
PORTREVISION=	1
CATEGORIES=	ports-mgmt

MAINTAINER=	jgh@FreeBSD.org
COMMENT=	"meta-port" for tools to test and submit changes to ports

USES=	metaport
# note: portlint is brought in by porttools
RUN_DEPENDS=	\
		${LOCALBASE}/bin/svn:${PORTSDIR}/devel/subversion \
		${LOCALBASE}/sbin/libchk:${PORTSDIR}/sysutils/libchk \
		${LOCALBASE}/bin/port:${PORTSDIR}/ports-mgmt/porttools

.include <bsd.port.mk>
