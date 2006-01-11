Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWAKAhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWAKAhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWAKAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:37:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19980 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932549AbWAKAhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:37:50 -0500
Date: Wed, 11 Jan 2006 01:37:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/{,wireless/}Kconfig: remove dead URL
Message-ID: <20060111003747.GJ3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shadow.cabi.net does no longer exist.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/Kconfig          |    4 ----
 drivers/net/wireless/Kconfig |    4 ----
 2 files changed, 8 deletions(-)

--- linux-2.6.15-mm2-full/drivers/net/Kconfig.old	2006-01-11 01:14:12.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/net/Kconfig	2006-01-11 01:16:43.000000000 +0100
@@ -2663,10 +2663,6 @@
 	  Class-Based Queueing (CBQ) scheduling support which you get if you
 	  say Y to "QoS and/or fair queueing" above.
 
-	  To set up and configure shaper devices, you need the shapecfg
-	  program, available from <ftp://shadow.cabi.net/pub/Linux/> in the
-	  shaper package.
-
 	  To compile this driver as a module, choose M here: the module
 	  will be called shaper.  If unsure, say N.
 
--- linux-2.6.15-mm2-full/drivers/net/wireless/Kconfig.old	2006-01-11 01:16:56.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/net/wireless/Kconfig	2006-01-11 01:17:08.000000000 +0100
@@ -24,10 +24,6 @@
 	  the tools from
 	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
 
-	  Some user-level drivers for scarab devices which don't require
-	  special kernel support are available from
-	  <ftp://shadow.cabi.net/pub/Linux/>.
-
 # Note : the cards are obsolete (can't buy them anymore), but the drivers
 # are not, as people are still using them...
 comment "Obsolete Wireless cards support (pre-802.11)"

