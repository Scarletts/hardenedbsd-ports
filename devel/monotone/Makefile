# Created by: Mark A. Wicks <mwicks@kettering.edu>
# $FreeBSD$

PORTNAME=	monotone
PORTVERSION=	1.1
PORTREVISION=	2
CATEGORIES=	devel
MASTER_SITES=	http://www.monotone.ca/downloads/${PORTVERSION}/

MAINTAINER=	lapo@lapo.it
COMMENT=	Distributed version control system with digital signatures

LICENSE=	GPLv2
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	${LOCALBASE}/include/boost/shared_ptr.hpp:${PORTSDIR}/devel/boost-libs
LIB_DEPENDS=	libpcre.so:${PORTSDIR}/devel/pcre \
		libidn.so:${PORTSDIR}/dns/libidn \
		libsqlite3.so:${PORTSDIR}/databases/sqlite3 \
		libbotan-1.10.so:${PORTSDIR}/security/botan110

SUB_FILES=	pkg-message
USES=		cpe gmake iconv localbase lua:51 makeinfo perl5 \
		pkgconfig tar:bzip2
USE_PERL5=	build

GNU_CONFIGURE=	yes
CONFIGURE_ENV=	MAKEINFO="makeinfo --no-split"

INFO=		monotone
PORTDOCS=	*

OPTIONS_DEFINE=	DOCS NLS
OPTIONS_SUB=	yes

NLS_USES=		gettext
NLS_CONFIGURE_OFF=	--disable-nls

post-extract:
	@${RM} -f ${WRKSRC}/monotone.info*

post-patch:
	@${REINPLACE_CMD} \
		-e "s/REBUILD_NLS=true/REBUILD_NLS=false/g" \
		-e "s/std::tr1::/std::/g" \
		${WRKSRC}/configure
	@${REINPLACE_CMD} \
		-e "s/std::tr1::/std::/g" \
		${WRKSRC}/src/hash_map.hh

post-patch-DOCS-off:
	@${REINPLACE_CMD} -Ee '/^install-(contrib|examples)-data:/{' -e 'n' -e 'd' -e '}' ${WRKSRC}/Makefile.in

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/share/zsh/site-functions
	${INSTALL_DATA} ${WRKSRC}/contrib/monotone.zsh_completion ${STAGEDIR}${PREFIX}/share/zsh/site-functions/_mtn

post-install-DOCS-on:
	${MKDIR} ${STAGEDIR}${DOCSDIR}
	cd ${WRKSRC} && ${INSTALL_DATA} NEWS UPGRADE ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
