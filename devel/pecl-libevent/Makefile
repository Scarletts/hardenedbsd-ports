# Created by: Ilya Bakulin <webmaster@kibab.com>
# $FreeBSD$

PORTNAME=	libevent
PORTVERSION=	0.1.0
CATEGORIES=	devel
MASTER_SITES=	http://pecl.php.net/get/
PKGNAMEPREFIX=	pecl-
DIST_SUBDIR=	PECL

MAINTAINER=	webmaster@kibab.com
COMMENT=	Libevent extension for PHP

LICENSE=	PHP301

LIB_DEPENDS=	libevent.so:${PORTSDIR}/devel/libevent2

USES=	tar:tgz

USE_PHP=	yes
USE_PHP_BUILD=	yes
USE_PHPIZE=	yes
USE_PHPEXT=	yes
PHP_MODNAME=	libevent

.include <bsd.port.mk>
