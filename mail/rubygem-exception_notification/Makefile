# Created by: Steve Wills <swills@FreeBSD.org>
# $FreeBSD$

PORTNAME=	exception_notification
PORTVERSION=	4.1.2
CATEGORIES=	mail rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Exception notification for Rails apps

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/MIT-LICENSE

RUN_DEPENDS=	rubygem-actionmailer4>=4.0:${PORTSDIR}/mail/rubygem-actionmailer4 \
		rubygem-activesupport4>=4.0:${PORTSDIR}/devel/rubygem-activesupport4

NO_ARCH=	yes
USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

.include <bsd.port.mk>
