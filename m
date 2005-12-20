Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVLTIF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVLTIF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVLTIF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:05:29 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:57606 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750844AbVLTIF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:05:28 -0500
Date: Tue, 20 Dec 2005 17:05:48 +0900 (JST)
Message-Id: <20051220.170548.108869605.yoshfuji@linux-ipv6.org>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FB: Typoes in Kconfig
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

FB: Fix typoes in Kconfig.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3e470c8..2fd2d18 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1376,7 +1376,7 @@ config FB_PXA
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called pxafb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
@@ -1409,7 +1409,7 @@ config FB_W100
 
 	  This driver is also available as a module ( = code which can be
 	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
+	  module will be called w100fb. If you want to compile it as a module,
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
