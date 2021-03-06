# $FreeBSD$

PORTNAME=	irssi
PORTVERSION=	0.8.17
PORTREVISION?=	1
CATEGORIES?=	irc
MASTER_SITES=	http://mirror.irssi.org/

MAINTAINER?=	vanilla@FreeBSD.org
COMMENT?=	Modular IRC client with many features

LICENSE=	GPLv2

LIB_DEPENDS=	libglib-2.0.so:${PORTSDIR}/devel/glib20

CONFLICTS=	irssi-devel-[0-9]* zh-irssi-[0-9]*

USES=		gmake libtool ncurses pkgconfig tar:bzip2
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--with-ncurses=${NCURSESBASE}
INSTALL_TARGET=	install-strip

USES+=		pie relro

OPTIONS_DEFINE=	PERL PROXY SOCKS IPV6 BOT DOCS TRUECOLOR
OPTIONS_DEFAULT=	PERL IPV6 DOCS
OPTIONS_SUB=	yes
SOCKS_DESC=	Socks proxy support
SOCKS_CONFIGURE_WITH=	socks
BOT_DESC=	Bot support
BOT_CONFIGURE_WITH=	bot
PERL_USES=	perl5
PERL_CONFIGURE_ON=	--with-perl-lib=site
PERL_CONFIGURE_OFF=	--with-perl=no
PROXY_CONFIGURE_WITH=	proxy
IPV6_CONFIGURE_ENABLE=	ipv6
IPV6_CATEGORIES=	ipv6
TRUECOLOR_DESC=	Truecolor (24bit) support
TRUECOLOR_CONFIGURE_ENABLE=	true-color

# USE_OPENSSL must be defined before bsd.port.pre.mk so use old schema
# for WITH_SSL option

.if defined(WITHOUT_SSL)
CONFIGURE_ARGS+=	--disable-ssl
.else
USE_OPENSSL=	yes
.endif

post-patch:
	@${REINPLACE_CMD} -e 's|/usr|${PREFIX}|' -e 's|/etc|${PREFIX}&|' \
		${WRKSRC}/docs/irssi.1

post-configure:
	@${MV} ${WRKSRC}/irssi.conf ${WRKSRC}/irssi.conf.sample

post-install:
	@${MKDIR} ${STAGEDIR}${PREFIX}/lib/irssi/modules

.include <bsd.port.mk>
