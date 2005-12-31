Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVLaW2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVLaW2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVLaW2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:28:54 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:41099 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965068AbVLaW2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:28:53 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 23:28:29 +0100
In-reply-to: <200512319343.965475189bla@anxur.fi.muni.cz>
Subject: [PATCH 4/4] media-video: Stradis Kconfig url changed
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, laredo@gnu.org,
       mchehab@brturbo.com.br, video4linux-list@redhat.com
Message-Id: <20051231222827.84BAF22AEE6@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stradis Kconfig url changed

http://www.stradis.com/decoder.html returns `No input file specified.'

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 86eb16fd48675def055ddfe10ed2d35a61c13e57
tree 597051af857549be824a9d40439cdc05234c033a
parent 213e9a2c513ad1b36ff6b459ca815813318b332b
author <ku@bellona.(none)> Sat, 31 Dec 2005 23:19:33 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 23:19:33 +0100

 drivers/media/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -174,7 +174,7 @@ config VIDEO_STRADIS
 	help
 	  Say Y here to enable support for the Stradis 4:2:2 MPEG-2 video
 	  driver for PCI.  There is a product page at
-	  <http://www.stradis.com/decoder.html>.
+	  <http://www.stradis.com/>.
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36067 Video For Linux"
