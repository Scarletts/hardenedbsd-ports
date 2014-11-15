.if !defined(_INCLUDE_USES_PIE_MK)
_INCLUDE_USES_PIE_MK=	yes
.if !defined(WITHOUT_PIE)
USE_PIE=		yes
.endif
.endif
