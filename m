Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVHPWQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVHPWQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVHPWQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:16:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:12433 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751124AbVHPWQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:22 -0400
Date: Tue, 16 Aug 2005 15:16:10 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
Subject: [patch 4/7] PCI Hotplug: new contact info
Message-ID: <20050816221610.GE28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-hotplug-new-contact-info.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristen Accardi <kristen.c.accardi@intel.com>

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS                            |   12 ++++++++++++
 drivers/pci/hotplug/pciehp.h           |    2 +-
 drivers/pci/hotplug/pciehp_core.c      |    2 +-
 drivers/pci/hotplug/pciehp_ctrl.c      |    2 +-
 drivers/pci/hotplug/pciehp_hpc.c       |    2 +-
 drivers/pci/hotplug/pciehp_pci.c       |    2 +-
 drivers/pci/hotplug/pciehprm.h         |    2 +-
 drivers/pci/hotplug/pciehprm_acpi.c    |    2 +-
 drivers/pci/hotplug/pciehprm_nonacpi.c |    2 +-
 drivers/pci/hotplug/pciehprm_nonacpi.h |    2 +-
 drivers/pci/hotplug/shpchp.h           |    2 +-
 drivers/pci/hotplug/shpchp_core.c      |    2 +-
 drivers/pci/hotplug/shpchp_ctrl.c      |    2 +-
 drivers/pci/hotplug/shpchp_hpc.c       |    2 +-
 drivers/pci/hotplug/shpchp_pci.c       |    2 +-
 drivers/pci/hotplug/shpchprm.h         |    2 +-
 drivers/pci/hotplug/shpchprm_acpi.c    |    2 +-
 drivers/pci/hotplug/shpchprm_legacy.c  |    2 +-
 drivers/pci/hotplug/shpchprm_legacy.h  |    2 +-
 drivers/pci/hotplug/shpchprm_nonacpi.c |    2 +-
 drivers/pci/hotplug/shpchprm_nonacpi.h |    2 +-
 21 files changed, 32 insertions(+), 20 deletions(-)

--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp_core.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp_core.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp_ctrl.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 #ifndef _PCIEHP_H
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp_hpc.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehp_pci.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehp_pci.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehprm_acpi.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehprm_acpi.c	2005-08-16 14:57:52.000000000 -0700
@@ -20,7 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <dely.l.sy@intel.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehprm.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehprm.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehprm_nonacpi.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/pciehprm_nonacpi.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/pciehprm_nonacpi.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp_core.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchp_core.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchp_ctrl.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchp.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 #ifndef _SHPCHP_H
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp_hpc.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchp_hpc.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchp_pci.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchp_pci.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm_acpi.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm_acpi.c	2005-08-16 14:57:52.000000000 -0700
@@ -20,7 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <dely.l.sy@intel.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm_legacy.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm_legacy.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>,<dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm_legacy.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm_legacy.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm_nonacpi.c	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/drivers/pci/hotplug/shpchprm_nonacpi.h	2005-08-16 14:51:31.000000000 -0700
+++ gregkh-2.6/drivers/pci/hotplug/shpchprm_nonacpi.h	2005-08-16 14:57:52.000000000 -0700
@@ -23,7 +23,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>, <dely.l.sy@intel.com>
+ * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
  */
 
--- gregkh-2.6.orig/MAINTAINERS	2005-08-16 14:55:51.000000000 -0700
+++ gregkh-2.6/MAINTAINERS	2005-08-16 14:57:52.000000000 -0700
@@ -1825,6 +1825,12 @@ P:	Greg Kroah-Hartman
 M:	greg@kroah.com
 S:	Maintained
 
+PCIE HOTPLUG DRIVER
+P:	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
+L:	pcihpd-discuss@lists.sourceforge.net
+S:	Maintained
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
@@ -2201,6 +2207,12 @@ W:	http://projects.buici.com/arm
 L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
 S:	Maintained
 
+SHPC HOTPLUG DRIVER
+P:	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
+L:	pcihpd-discuss@lists.sourceforge.net
+S:	Maintained
+
 SPARC (sparc32):
 P:	William L. Irwin
 M:	wli@holomorphy.com

--
