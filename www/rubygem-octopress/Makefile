# $FreeBSD$

PORTNAME=	octopress
PORTVERSION=	3.0.11
CATEGORIES=	www rubygems
MASTER_SITES=	RG

MAINTAINER=	ruby@FreeBSD.org
COMMENT=	Static blogging framework leveraging Jekyll

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	rubygem-jekyll2>=2.0:${PORTSDIR}/www/rubygem-jekyll2 \
		rubygem-mercenary>=0.3.2:${PORTSDIR}/devel/rubygem-mercenary \
		rubygem-octopress-deploy>=0:${PORTSDIR}/net/rubygem-octopress-deploy \
		rubygem-octopress-escape-code>=2.0:${PORTSDIR}/textproc/rubygem-octopress-escape-code \
		rubygem-octopress-hooks>=2.0:${PORTSDIR}/devel/rubygem-octopress-hooks \
		rubygem-redcarpet>=3.0:${PORTSDIR}/textproc/rubygem-redcarpet \
		rubygem-titlecase>=0:${PORTSDIR}/devel/rubygem-titlecase

NO_ARCH=	yes
USE_RUBY=	yes
USE_RUBYGEMS=	yes
RUBYGEM_AUTOPLIST=	yes

PLIST_FILES=	bin/octopress

.include <bsd.port.mk>
