Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQKNRPQ>; Tue, 14 Nov 2000 12:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQKNRPG>; Tue, 14 Nov 2000 12:15:06 -0500
Received: from web.sajt.cz ([212.71.160.9]:43281 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129518AbQKNRO7>;
	Tue, 14 Nov 2000 12:14:59 -0500
Date: Tue, 14 Nov 2000 17:44:53 +0100 (CET)
From: Pavel Rabel <pavel@web.sajt.cz>
To: linux-kernel@vger.kernel.org
Subject: [patch] CONFIG_SOUND_MAD16 help
Message-ID: <Pine.LNX.4.21.0011141741530.25604-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The mentioned file drivers/sound/README.C931 doesn't exist.
Is the README file somewhere else?

Pavel Rabel


--- Configure.help.old	Tue Nov 14 16:49:34 2000
+++ Configure.help	Tue Nov 14 16:52:08 2000
@@ -14045,8 +14045,7 @@
 Support for OPTi MAD16 and/or Mozart based cards
 CONFIG_SOUND_MAD16
   Answer Y if your card has a Mozart (OAK OTI-601) or MAD16 (OPTi
-  82C928 or 82C929 or 82C931) audio interface chip. For the 82C931,
-  please read drivers/sound/README.C931. These chips are currently
+  82C928 or 82C929 or 82C931) audio interface chip. These chips are 
   quite common so it's possible that many no-name cards have one of
   them. In addition the MAD16 chip is used in some cards made by known
   manufacturers such as Turtle Beach (Tropez), Reveal (some models)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
