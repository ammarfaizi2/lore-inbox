Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVHETE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVHETE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVHETDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:03:13 -0400
Received: from fmr20.intel.com ([134.134.136.19]:56237 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S263101AbVHES7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:59:41 -0400
Subject: Re: [PATCH] new contact info
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
In-Reply-To: <20050805183626.GB32405@kroah.com>
References: <1123260594.8917.13.camel@whizzy>
	 <200508051109.56230.bjorn.helgaas@hp.com> <1123265168.8917.22.camel@whizzy>
	 <20050805183626.GB32405@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 11:59:28 -0700
Message-Id: <1123268368.8917.30.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 18:59:29.0745 (UTC) FILETIME=[CEE7AC10:01C599EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 11:36 -0700, Greg KH wrote:
> On Fri, Aug 05, 2005 at 11:06:08AM -0700, Kristen Accardi wrote:
> > diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/MAINTAINERS linux-2.6.13-rc5-new/MAINTAINERS
> > --- linux-2.6.13-rc5/MAINTAINERS	2005-08-01 21:45:48.000000000 -0700
> > +++ linux-2.6.13-rc5-new/MAINTAINERS	2005-08-05 11:03:36.000000000 -0700
> > @@ -1825,6 +1825,11 @@ P:	Greg Kroah-Hartman
> >  M:	greg@kroah.com
> >  S:	Maintained
> >  
> > +PCIE HOTPLUG DRIVER
> > +P:	Kristen Carlson Accardi
> > +M:	kristen.c.accardi@intel.com
> > +S:	Maintained
> 
> Care to try it again, and add the pcihpd mailing list address too?  That
> is the place to talk about pci hotplug drivers, right?
> 
> thanks,
> 
> greg k-h

Ok.

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
 
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/MAINTAINERS linux-2.6.13-rc5-new/MAINTAINERS
--- linux-2.6.13-rc5/MAINTAINERS	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-new/MAINTAINERS	2005-08-05 11:57:12.000000000 -0700
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

