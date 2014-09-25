PORTNAME=	testpie
PORTVERSION=	1.0
CATEGORIES=	hardenedbsd
MAINTAINER=	shawn.webb@hardenedbsd.org
MASTER_SITES=	http://hardenedbsd.org/distfiles/

do-install:
	cp ${WRKSRC}/testpie ${STAGEDIR}${PREFIX}/bin/testpie
	chmod u+rx,g+rx,o+rx ${STAGEDIR}${PREFIX}/bin/testpie

PLIST_FILES= \
	bin/testpie

.include <bsd.port.mk>
