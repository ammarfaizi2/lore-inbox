Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbQKJUiZ>; Fri, 10 Nov 2000 15:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbQKJUiS>; Fri, 10 Nov 2000 15:38:18 -0500
Received: from web.sajt.cz ([212.71.160.9]:41487 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S131712AbQKJUhl>;
	Fri, 10 Nov 2000 15:37:41 -0500
Date: Fri, 10 Nov 2000 21:37:00 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: linux-kernel@vger.kernel.org
cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [patch] matroxfb.txt
Message-ID: <Pine.LNX.4.21.0011102132490.821-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in Documentation/fb/matroxfb.txt

Pavel Rabel

--- matroxfb.txt.old	Fri Nov 10 20:39:39 2000
+++ matroxfb.txt	Fri Nov 10 20:40:11 2000
@@ -253,7 +253,7 @@
            `vesa'.
 
 If you know capabilities of your monitor, you can specify some (or all) of
-`pixclk', `fh' and `fv'. In this case, `pixclock' is computed so that
+`maxclk', `fh' and `fv'. In this case, `pixclock' is computed so that
 pixclock <= maxclk, real_fh <= fh and real_fv <= fv.
 
 maxclk:X - maximum dotclock. X can be specified in MHz, kHz or Hz. Default is

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
