# $FreeBSD$
#
# Compile a port with PIE flags
#
# Feature:      pie
# Usage:        USES=pie
#
# MAINTAINER:	shawn.webb@hardenedbsd.org

.if ${OSVERSION} > 1100000 || !defined(POUDRIERE_VERSION)
.if !defined(_INCLUDE_USES_PIE_MK)
_INCLUDE_USES_PIE_MK=    yes

CFLAGS+=	-fPIE
CXXFLAGS+=	-fPIE
LDFLAGS+=	-pie

.endif
.endif
