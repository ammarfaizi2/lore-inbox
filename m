Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbRBDRW3>; Sun, 4 Feb 2001 12:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRBDRWT>; Sun, 4 Feb 2001 12:22:19 -0500
Received: from sv.moemoe.gr.jp ([211.10.15.35]:53520 "HELO mail.moemoe.gr.jp")
	by vger.kernel.org with SMTP id <S129090AbRBDRWP>;
	Sun, 4 Feb 2001 12:22:15 -0500
Date: Mon, 05 Feb 2001 02:22:11 +0900
From: Keitaro Yosimura <ramsy@linux.or.jp>
To: axel@uni-paderborn.de, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Configure.help typo fix
Cc: linux-kernel@vger.kernel.org, takei@webmasters.gr.jp
Message-Id: <20010205021325.755D.RAMSY@linux.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Axel Boldt, Alan Cox, Linus Torvalds.

We found Configure.help typo. please fix it.

==== for 2.2.X
--- linux.orig/Documentation/Configure.help	Mon Feb  5 02:07:04 2001
+++ linux/Documentation/Configure.help	Mon Feb  5 02:07:52 2001
@@ -1530,7 +1530,7 @@
   inserted in and removed from the running kernel whenever you want).
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt. You will get modules called i2o_core.o
-  and i20_config.o. 
+  and i2o_config.o. 
 
   If unsure, say N.
 
==== for 2.4.X
--- linux.orig/Documentation/Configure.help	Mon Feb  5 02:09:05 2001
+++ linux/Documentation/Configure.help	Mon Feb  5 02:09:50 2001
@@ -2572,7 +2572,7 @@
   inserted in and removed from the running kernel whenever you want).
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt. You will get modules called i2o_core.o
-  and i20_config.o. 
+  and i2o_config.o. 
 
   If unsure, say N.
 
====

<|> YOSHIMURA 'ramsy' Keitaro / Japan Linux Association
<|> mailto:ramsy@linux.or.jp
<|> http://jla.linux.or.jp/index.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
