# Created by: Brendan Molloy <brendan+freebsd@bbqsrc.net>
# $FreeBSD$

PORTNAME=	unpaddedbase64
PORTVERSION=	1.0.1
DISTVERSIONPREFIX=	v
CATEGORIES=	devel python
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	brendan+freebsd@bbqsrc.net
COMMENT=	Unpadded Base64

LICENSE=	APACHE20
LICENSE_FILE=	${WRKSRC}/LICENSE

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pytest>0:${PORTSDIR}/devel/py-pytest

USES=		python
USE_GITHUB=	yes
USE_PYTHON=	autoplist distutils

GH_ACCOUNT=	matrix-org
GH_PROJECT=	python-unpaddedbase64

NO_ARCH=	yes

do-test:
	@(cd ${WRKSRC} && ${PYTHON_CMD} -m pytest)

.include <bsd.port.mk>
