Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262923AbSJHTBE>; Tue, 8 Oct 2002 15:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHTAA>; Tue, 8 Oct 2002 15:00:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14608 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262602AbSJHS7A>; Tue, 8 Oct 2002 14:59:00 -0400
Subject: PATCH: fix cut and paste error in amd768rng help
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:56:10 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzWc-0004rk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/char/Config.help linux.2.5.41-ac1/drivers/char/Config.help
--- linux.2.5.41/drivers/char/Config.help	2002-10-07 22:12:22.000000000 +0100
+++ linux.2.5.41-ac1/drivers/char/Config.help	2002-10-07 22:24:42.000000000 +0100
@@ -659,7 +659,7 @@
   To compile this driver as a module ( = code which can be inserted in
   and removed from the running kernel whenever you want), say M here
   and read <file:Documentation/modules.txt>. The module will be called
-  i810_rng.o.
+  amd768_rng.o.
 
   If unsure, say N.
 
