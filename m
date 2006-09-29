Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWI2Ra7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWI2Ra7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWI2Ra7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:30:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:18693 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751130AbWI2Ra6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:30:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,238,1157353200"; 
   d="scan'208"; a="124892639:sNHT23604553"
Date: Fri, 29 Sep 2006 10:30:27 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [patch] change pci hotplug subsystem maintainer to Kristen
Message-Id: <20060929103027.84bc7aab.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Here's a patch adding me to the maintainers file for the pci 
hotplug subsystem, as we discussed.

Thanks,
Kristen

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 MAINTAINERS                            |    4 ++--
 drivers/pci/hotplug/pci_hotplug.h      |    2 +-
 drivers/pci/hotplug/pci_hotplug_core.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/MAINTAINERS
+++ gregkh-2.6/MAINTAINERS
@@ -2285,8 +2285,8 @@ T:	quilt kernel.org/pub/linux/kernel/peo
 S:	Supported
 
 PCI HOTPLUG CORE
-P:	Greg Kroah-Hartman
-M:	gregkh@suse.de
+P: 	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
 S:	Supported
 
 PCI HOTPLUG COMPAQ DRIVER
--- gregkh-2.6.orig/drivers/pci/hotplug/pci_hotplug.h
+++ gregkh-2.6/drivers/pci/hotplug/pci_hotplug.h
@@ -22,7 +22,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 #ifndef _PCI_HOTPLUG_H
--- gregkh-2.6.orig/drivers/pci/hotplug/pci_hotplug_core.c
+++ gregkh-2.6/drivers/pci/hotplug/pci_hotplug_core.c
@@ -21,7 +21,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <greg@kroah.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  * Filesystem portion based on work done by Pat Mochel on ddfs/driverfs
  *
