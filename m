Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277131AbRJHUz6>; Mon, 8 Oct 2001 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277134AbRJHUzs>; Mon, 8 Oct 2001 16:55:48 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:273 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S277131AbRJHUzg>; Mon, 8 Oct 2001 16:55:36 -0400
Subject: PATCH -- Update e-mail address for Giuliano Procida
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Giuliano Procida <myxie@debian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 08 Oct 2001 13:47:35 -0700
Message-Id: <1002574055.14769.35.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a mail system bounce from his Madge address.  I found the 
Debian address through a web search and that address did not bounce.
Giuliano, please correct me if this is not the correct address for you
or you wish to be unlisted.

Thanks,
	Miles

diff -u --new-file linux/drivers/atm/ambassador.c~ linux/drivers/atm/ambassador.c
--- linux/drivers/atm/ambassador.c~	Mon Oct  1 14:21:55 2001
+++ linux/drivers/atm/ambassador.c	Mon Oct  8 13:24:58 2001
@@ -38,7 +38,7 @@
 
 #include "ambassador.h"
 
-#define maintainer_string "Giuliano Procida at Madge Networks <gprocida@madge.com>"
+#define maintainer_string "Giuliano Procida <myxie@debian.org>"
 #define description_string "Madge ATM Ambassador driver"
 #define version_string "1.2.4"
 
diff -u --new-file linux/drivers/atm/horizon.c~ linux/drivers/atm/horizon.c
--- linux/drivers/atm/horizon.c~	Mon Oct  1 14:21:55 2001
+++ linux/drivers/atm/horizon.c	Mon Oct  8 13:25:21 2001
@@ -49,7 +49,7 @@
 
 #include "horizon.h"
 
-#define maintainer_string "Giuliano Procida at Madge Networks <gprocida@madge.com>"
+#define maintainer_string "Giuliano Procida <myxie@debian.org>"
 #define description_string "Madge ATM Horizon [Ultra] driver"
 #define version_string "1.2.1"
 




