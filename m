Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTBOTVw>; Sat, 15 Feb 2003 14:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBOTUr>; Sat, 15 Feb 2003 14:20:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64272 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265140AbTBOTU3>; Sat, 15 Feb 2003 14:20:29 -0500
Subject: PATCH: another ia64 typo
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:30:42 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k81K-0007KN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/asm-ia64/sn/router.h linux-2.5.61-ac1/include/asm-ia64/sn/router.h
--- linux-2.5.61/include/asm-ia64/sn/router.h	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.61-ac1/include/asm-ia64/sn/router.h	2003-02-14 23:30:42.000000000 +0000
@@ -500,7 +500,7 @@
 
 	/*
 	 * Everything below here is for kernel use only and may change at	
-	 * at any time with or without a change in teh revision number
+	 * at any time with or without a change in the revision number
 	 *
 	 * Any pointers or things that come and go with DEBUG must go at
  	 * the bottom of the structure, below the user stuff.
