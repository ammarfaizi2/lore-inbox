Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSGKHof>; Thu, 11 Jul 2002 03:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317786AbSGKHoe>; Thu, 11 Jul 2002 03:44:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:5343 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317785AbSGKHod>; Thu, 11 Jul 2002 03:44:33 -0400
Date: Thu, 11 Jul 2002 09:47:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Albert Cranford <ac9410@bellsouth.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.25 I2C driver id and Config updates
In-Reply-To: <3D2D1712.DA5D89E8@bellsouth.net>
Message-ID: <Pine.NEB.4.44.0207110941200.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

<--  snip  -->

--- linux/drivers/i2c/Config.help.orig  2002-07-07 16:41:47.000000000
-0400
+++ linux/drivers/i2c/Config.help       2002-07-07 16:45:21.000000000
-0400
@@ -1,3 +1,4 @@
+I2C support
 CONFIG_I2C
   I2C (pronounce: I-square-C) is a slow serial bus protocol used in
   many micro controller applications and developed by Philips.  SMBus,
...

<--  snip  -->


What is the purpose of this patch? I can't see it making any difference
(at least ot in menuconfig).


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



