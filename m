Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWAXV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWAXV6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWAXV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:58:06 -0500
Received: from colibri.its.UU.SE ([130.238.4.154]:63190 "EHLO
	colibri.its.uu.se") by vger.kernel.org with ESMTP id S1750762AbWAXV6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:58:04 -0500
Date: Tue, 24 Jan 2006 23:06:02 +0100 (CET)
From: johann.deneux@gmail.com
X-X-Sender: johann@minime.minihome
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] 2.6.16-rc1 HID: changed email
Message-ID: <Pine.LNX.4.60.0601242304580.9453@minime.minihome>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed email address of Johann Deneux (myself)
Also removed $$ in comments (no longer using cvs)

Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

---
commit 160f2f07187e5cb23c5efc02824e1a6a0ad06e4e
tree f990e9969b2e9317bb45d2329b1fce36b415889a
parent dc4756e0d0dcb8c44fc1d93674b4e768d9cfb42f
author Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:41:02 +0100
committer Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:41:02 
+0100

  drivers/usb/input/hid-ff.c   |    4 +---
  drivers/usb/input/hid-lgff.c |    6 ++----
  2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/input/hid-ff.c b/drivers/usb/input/hid-ff.c
index 72e6986..19f592d 100644
--- a/drivers/usb/input/hid-ff.c
+++ b/drivers/usb/input/hid-ff.c
@@ -1,6 +1,4 @@
  /*
- * $Id: hid-ff.c,v 1.2 2002/04/18 22:02:47 jdeneux Exp $
- *
   *  Force feedback support for hid devices.
   *  Not all hid devices use the same protocol. For example, some use PID,
   *  other use their own proprietary procotol.
@@ -24,7 +22,7 @@
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
   *
   * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <johann.deneux@it.uu.se>
+ * e-mail - mail your message to <johann.deneux@gmail.com>
   */

  #include <linux/input.h>
diff --git a/drivers/usb/input/hid-lgff.c b/drivers/usb/input/hid-lgff.c
index f82c9c9..07f409f 100644
--- a/drivers/usb/input/hid-lgff.c
+++ b/drivers/usb/input/hid-lgff.c
@@ -1,6 +1,4 @@
  /*
- * $$
- *
   * Force feedback support for hid-compliant for some of the devices from
   * Logitech, namely:
   * - WingMan Cordless RumblePad
@@ -25,7 +23,7 @@
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
   *
   * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <johann.deneux@it.uu.se>
+ * e-mail - mail your message to <johann.deneux@gmail.com>
   */

  #include <linux/input.h>
@@ -207,7 +205,7 @@ int hid_lgff_init(struct hid_device* hid
  	add_timer(&private->timer);  /*TODO: only run the timer when at least
  				       one effect is playing */

-	printk(KERN_INFO "Force feedback for Logitech force feedback devices by 
Johann Deneux <johann.deneux@it.uu.se>\n");
+	printk(KERN_INFO "Force feedback for Logitech force feedback devices by 
Johann Deneux <johann.deneux@gmail.com>\n");

  	return 0;
  }
