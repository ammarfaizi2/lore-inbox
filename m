Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268315AbTCCDdY>; Sun, 2 Mar 2003 22:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268317AbTCCDdY>; Sun, 2 Mar 2003 22:33:24 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:65291 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268315AbTCCDdV>; Sun, 2 Mar 2003 22:33:21 -0500
Subject: [PATCH] 2.5.63-current fix Coverted -> Converted , was (Re: [PATCH]
	kernel source spellchecker)
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: "Jared Daniel J. Smith" <linux@trios.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1046644335.3700.30.camel@irongate.swansea.linux.org.uk>
References: <20030302165127Z269240-29902+1551@vger.kernel.org>
	<1046630795.10138.495.camel@spc1.mesatop.com> 
	<1046644335.3700.30.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 02 Mar 2003 20:42:24 -0700
Message-Id: <1046662946.7527.526.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes what might have been a joke, but wasn't.

Coverted -> Converted

One down, 285 to go.

Steven

On Sun, 2003-03-02 at 15:32, Alan Cox wrote:
> On Sun, 2003-03-02 at 18:46, Steven Cole wrote:
> > ./drivers/media/radio/radio-aimslab.c: * Coverted to new API by Alan Cox <Alan.Cox@linux.org>
> > ./drivers/media/radio/radio-gemtek.c: *    Coverted to new API by Alan Cox <Alan.Cox@linux.org>
> > ./drivers/media/radio/radio-rtrack2.c: * Coverted to new API by Alan Cox <Alan.Cox@linux.org>
> > 
> > Alan's humor can be subtle.  Better to ask him. AC added to cc list.
> 
> Cut & waste accident. Those should be fixed
> 
> 

diff -ur bk-current/drivers/media/radio/radio-aimslab.c linux/drivers/media/radio/radio-aimslab.c
--- bk-current/drivers/media/radio/radio-aimslab.c	Sun Mar  2 20:12:31 2003
+++ linux/drivers/media/radio/radio-aimslab.c	Sun Mar  2 20:30:04 2003
@@ -1,6 +1,6 @@
 /* radiotrack (radioreveal) driver for Linux radio support
  * (c) 1997 M. Kirkwood
- * Coverted to new API by Alan Cox <Alan.Cox@linux.org>
+ * Converted to new API by Alan Cox <Alan.Cox@linux.org>
  * Various bugfixes and enhancements by Russell Kroll <rkroll@exploits.org>
  *
  * History:
diff -ur bk-current/drivers/media/radio/radio-gemtek.c linux/drivers/media/radio/radio-gemtek.c
--- bk-current/drivers/media/radio/radio-gemtek.c	Sun Mar  2 20:11:13 2003
+++ linux/drivers/media/radio/radio-gemtek.c	Sun Mar  2 20:30:26 2003
@@ -8,7 +8,7 @@
  *    RadioTrack II driver for Linux radio support (C) 1998 Ben Pfaff
  * 
  *    Based on RadioTrack I/RadioReveal (C) 1997 M. Kirkwood
- *    Coverted to new API by Alan Cox <Alan.Cox@linux.org>
+ *    Converted to new API by Alan Cox <Alan.Cox@linux.org>
  *    Various bugfixes and enhancements by Russell Kroll <rkroll@exploits.org>
  *
  * TODO: Allow for more than one of these foolish entities :-)
diff -ur bk-current/drivers/media/radio/radio-rtrack2.c linux/drivers/media/radio/radio-rtrack2.c
--- bk-current/drivers/media/radio/radio-rtrack2.c	Sun Mar  2 20:14:08 2003
+++ linux/drivers/media/radio/radio-rtrack2.c	Sun Mar  2 20:30:36 2003
@@ -1,7 +1,7 @@
 /* RadioTrack II driver for Linux radio support (C) 1998 Ben Pfaff
  * 
  * Based on RadioTrack I/RadioReveal (C) 1997 M. Kirkwood
- * Coverted to new API by Alan Cox <Alan.Cox@linux.org>
+ * Converted to new API by Alan Cox <Alan.Cox@linux.org>
  * Various bugfixes and enhancements by Russell Kroll <rkroll@exploits.org>
  *
  * TODO: Allow for more than one of these foolish entities :-)

