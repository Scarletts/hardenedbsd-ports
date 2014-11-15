# $FreeBSD$
# PIE Support

PIE_Include_MAINTAINER=	shawn.webb@hardenedbsd.org

.if ${PORT_OPTIONS:MPIE} && \
	 (${ARCH} == "i386" || ${ARCH} == "amd64")
PIEFLAG=	-fPIE
CFLAGS+=	${PIEFLAG}
CXXFLAGS+=	${PIEFLAG}
LDFLAGS+=	-pie
.endif
