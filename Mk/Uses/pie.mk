# $FreeBSD$
#
# Compile a port with PIE flags
#
# Feature:      pie
# Usage:        USES=pie
#
# MAINTAINER:	shawn.webb@hardenedbsd.org

.if !defined(_INCLUDE_USES_PIE_MK)
_INCLUDE_USES_PIE_MK=    yes

.if ${OSVERSION} < 1100000
.info "PIE support disabled on < 11-CURRENT"
.else
CFLAGS+=	-fPIE
CXXFLAGS+=	-fPIE
LDFLAGS+=	-pie
.endif

.endif
