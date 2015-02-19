--- src/fwalls/ipfw.c.orig	2015-02-16 18:12:16.419102000 -0500
+++ src/fwalls/ipfw.c	2015-02-16 18:12:55.219592000 -0500
@@ -39,11 +39,11 @@
 #define MAXIPFWCMDLEN           90
 
 #ifndef IPFW_RULERANGE_MIN
-#define IPFW_RULERANGE_MIN      55000
+#define IPFW_RULERANGE_MIN      1010
 #endif
 
 #ifndef IPFW_RULERANGE_MAX
-#define IPFW_RULERANGE_MAX      55050
+#define IPFW_RULERANGE_MAX      1090
 #endif
 
 typedef uint16_t ipfw_rulenumber_t;
