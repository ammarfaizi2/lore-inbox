Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262521AbTCRQFh>; Tue, 18 Mar 2003 11:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbTCRQFg>; Tue, 18 Mar 2003 11:05:36 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:45202 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262521AbTCRQFf>;
	Tue, 18 Mar 2003 11:05:35 -0500
Date: Tue, 18 Mar 2003 17:16:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Patrick Mochel <mochel@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: sysfs.txt spelling
Message-ID: <Pine.GSO.4.21.0303181715280.17808-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.65/Documentation/filesystems/sysfs.txt.orig	Tue Mar 18 11:26:44 2003
+++ linux-2.5.65/Documentation/filesystems/sysfs.txt	Tue Mar 18 16:24:46 2003
@@ -60,7 +60,7 @@
 you publically humiliated and your code rewritten without notice. 
 
 
-An attriubte definition is simply:
+An attribute definition is simply:
 
 struct attribute {
         char                    * name;
@@ -261,7 +261,7 @@
 that point to the device's directory under root/.
 
 drivers/ contains a directory for each device driver that is loaded
-for devices on that particular bus (this assmumes that drivers do not
+for devices on that particular bus (this assumes that drivers do not
 span multiple bus types).
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

