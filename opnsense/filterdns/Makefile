PORTNAME=	filterdns
PORTVERSION=	0.2
CATEGORIES=	sysutils
MASTER_SITES=	# empty
DISTFILES=	# none
EXTRACT_ONLY=	# empty

MAINTAINER=	franco@opnsense.org
COMMENT=	filterdns

PLIST_FILES=    sbin/filterdns

USES=	pie

do-extract:
	${CP} -r ${FILESDIR} ${WRKSRC}

.include <bsd.port.mk>
