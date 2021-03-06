# $FreeBSD$

PORTNAME=	rmilter
PORTVERSION=	1.6.7
CATEGORIES=	mail

MAINTAINER=	vsevolod@FreeBSD.org
COMMENT=	Milter that performs spamd, clamav, and spf checks

LICENSE=	BSD2CLAUSE

LIB_DEPENDS=	libpcre.so:${PORTSDIR}/devel/pcre \
		libspf2.so:${PORTSDIR}/mail/libspf2 \
		libopendkim.so:${PORTSDIR}/mail/opendkim

USE_GITHUB=	yes
GH_ACCOUNT=	vstakhov

USE_RC_SUBR=	yes
USES=		cmake:outsource bison
USE_OPENSSL=	yes

USERS=		_rmilter
GROUPS=		_rmilter

CMAKE_ARGS+=	-DENABLE_SPF=ON \
		-DENABLE_DKIM=ON

WITH_SENDMAIL_BASE=	yes

.include <bsd.port.pre.mk>

# Workaround to prevent bsd.milter.mk from breaking the build with the recent clang
WITHOUT_MILTER_LDFLAGS=	yes
.include "${PORTSDIR}/mail/sendmail/bsd.milter.mk"

post-patch:
	${SED} ${SUB_LIST:S/$/!g/:S/^/ -e s!%%/:S/=/%%!/} \
		${WRKSRC}/freebsd/rmilter > ${WRKDIR}/rmilter

do-install:
	${INSTALL_SCRIPT} ${WRKDIR}/rmilter ${STAGEDIR}${PREFIX}/etc/rc.d/
	${INSTALL_PROGRAM} ${BUILD_WRKSRC}/rmilter ${STAGEDIR}${PREFIX}/sbin
	${INSTALL_DATA} ${WRKSRC}/rmilter.conf.sample ${STAGEDIR}${PREFIX}/etc/
	${INSTALL_MAN} ${WRKSRC}/doc/rmilter.8 ${STAGEDIR}${MAN8PREFIX}/man/man8/

post-stage:
	${INSTALL} -d ${STAGEDIR}/var/run/rmilter
.include <bsd.port.post.mk>
