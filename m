Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWGZRws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWGZRws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWGZRws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:52:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:40023 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030372AbWGZRwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:52:47 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105090762:sNHT4028515092"
Date: Wed, 26 Jul 2006 10:52:33 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       len.brown@intel.com
Subject: [patch] pci/hotplug: add acpiphp to MAINTAINERS
Message-Id: <20060726105233.b31b5135.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpiphp to the MAINTAINERS file.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 MAINTAINERS                        |    6 ++++++
 drivers/pci/hotplug/acpiphp_core.c |    3 +--
 drivers/pci/hotplug/acpiphp_glue.c |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

--- 2.6-git.orig/MAINTAINERS
+++ 2.6-git/MAINTAINERS
@@ -214,6 +214,12 @@ W:	http://acpi.sourceforge.net/
 T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
 S:	Maintained
 
+ACPI PCI HOTPLUG DRIVER
+P:	Kristen Carlson Accardi
+M:	kristen.c.accardi@intel.com
+L:	pcihpd-discuss@lists.sourceforge.net
+S:	Maintained
+
 AD1816 SOUND DRIVER
 P:	Thorsten Knabe
 M:	Thorsten Knabe <linux@thorsten-knabe.de>
--- 2.6-git.orig/drivers/pci/hotplug/acpiphp_core.c
+++ 2.6-git/drivers/pci/hotplug/acpiphp_core.c
@@ -27,8 +27,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <gregkh@us.ibm.com>,
- *		    <t-kochi@bq.jp.nec.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
--- 2.6-git.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ 2.6-git/drivers/pci/hotplug/acpiphp_glue.c
@@ -26,7 +26,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <t-kochi@bq.jp.nec.com>
+ * Send feedback to <kristen.c.accardi@intel.com>
  *
  */
 
