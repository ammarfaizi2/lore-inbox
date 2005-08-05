Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVHEQvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVHEQvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVHEQvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:51:50 -0400
Received: from fmr18.intel.com ([134.134.136.17]:5861 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263067AbVHEQt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:49:59 -0400
Subject: [PATCH] new contact info
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rajesh.shah@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 09:49:54 -0700
Message-Id: <1123260594.8917.13.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 16:49:55.0472 (UTC) FILETIME=[B513C100:01C599DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changing of the guards.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_core.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_core.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_core.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_core.c	2005-08-05 09:34:57.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_ctrl.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_ctrl.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-05 09:35:31.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehp.h linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehp.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp.h	2005-08-05 09:35:48.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 #ifndef _PCIEHP_H
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_hpc.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_hpc.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_hpc.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_hpc.c	2005-08-05 09:36:07.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_pci.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_pci.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehp_pci.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehp_pci.c	2005-08-05 09:36:24.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_acpi.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_acpi.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_acpi.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_acpi.c	2005-08-05 09:36:48.000000000 -0700
@@ -20,7 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <dely.l.sy@intel.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm.h linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm.h	2005-08-05 09:37:07.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_nonacpi.c linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_nonacpi.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-08-05 09:37:27.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_nonacpi.h linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_nonacpi.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/pciehprm_nonacpi.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/pciehprm_nonacpi.h	2005-08-05 09:39:59.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_core.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_core.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_core.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_core.c	2005-08-05 09:37:47.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_ctrl.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_ctrl.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-05 09:38:02.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchp.h linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchp.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp.h	2005-08-05 09:38:12.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 #ifndef _SHPCHP_H
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_hpc.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_hpc.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_hpc.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_hpc.c	2005-08-05 09:38:21.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_pci.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_pci.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchp_pci.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchp_pci.c	2005-08-05 09:38:30.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_acpi.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_acpi.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_acpi.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_acpi.c	2005-08-05 09:38:39.000000000 -0700
@@ -20,7 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <dely.l.sy@intel.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm.h linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm.h	2005-08-05 09:38:47.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_legacy.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_legacy.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_legacy.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_legacy.c	2005-08-05 09:38:55.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_legacy.h linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_legacy.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_legacy.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_legacy.h	2005-08-05 09:39:04.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_nonacpi.c linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_nonacpi.c
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-08-05 09:39:12.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_nonacpi.h linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_nonacpi.h
--- linux-2.6.13-rc5/drivers/pci/hotplug/shpchprm_nonacpi.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/drivers/pci/hotplug/shpchprm_nonacpi.h	2005-08-05 09:39:23.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 

