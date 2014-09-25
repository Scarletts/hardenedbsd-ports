# $FreeBSD$
# PIE Support

PIE_Include_MAINTAINER=	shawn.webb@hardenedbsd.org

.if !defined(WITHOUT_PIE) && \
    (${ARCH} == i386 || ${ARCH} == amd64)
# Overridable as a user may want to use -fstack-protector-all
PIE_CFLAGS?=	-fPIE
CFLAGS+=	${PIE_CFLAGS}
CXXFLAGS+=	${PIE_CFLAGS}
LDFLAGS+=	-pie
.endif
