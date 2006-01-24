Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAXWBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAXWBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWAXWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:01:16 -0500
Received: from colibri.its.UU.SE ([130.238.4.154]:25564 "EHLO
	colibri.its.uu.se") by vger.kernel.org with ESMTP id S1750747AbWAXWBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:01:16 -0500
Date: Tue, 24 Jan 2006 23:09:17 +0100 (CET)
From: johann.deneux@gmail.com
X-X-Sender: johann@minime.minihome
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] 2.6.16-rc1 Input: IFORCE - email change
Message-ID: <Pine.LNX.4.60.0601242307140.9453@minime.minihome>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed email address of Johann Deneux (myself)

Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

---
commit 8a5dc8956857be543e2f0256fb0b071dfeca798a
tree 6722fb66bb79c3a710673f767e14bc1932126669
parent 82b3dbf4584205ed7aee044e82616c84753cdc8d
author Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:53:06 +0100
committer Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:53:06 
+0100

  drivers/input/joystick/iforce/iforce-ff.c      |    2 +-
  drivers/input/joystick/iforce/iforce-main.c    |    4 ++--
  drivers/input/joystick/iforce/iforce-packets.c |    2 +-
  drivers/input/joystick/iforce/iforce-serio.c   |    2 +-
  drivers/input/joystick/iforce/iforce-usb.c     |    2 +-
  drivers/input/joystick/iforce/iforce.h         |    2 +-
  6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-ff.c 
b/drivers/input/joystick/iforce/iforce-ff.c
index 4678b6d..a38d8ed 100644
--- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -2,7 +2,7 @@
   * $Id: iforce-ff.c,v 1.9 2002/02/02 19:28:35 jdeneux Exp $
   *
   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
diff --git a/drivers/input/joystick/iforce/iforce-main.c 
b/drivers/input/joystick/iforce/iforce-main.c
index 64b9c31..45b3816 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -2,7 +2,7 @@
   * $Id: iforce-main.c,v 1.19 2002/07/07 10:22:50 jdeneux Exp $
   *
   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
@@ -29,7 +29,7 @@

  #include "iforce.h"

-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <deneux@ifrance.com>");
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>");
  MODULE_DESCRIPTION("USB/RS232 I-Force joysticks and wheels driver");
  MODULE_LICENSE("GPL");

diff --git a/drivers/input/joystick/iforce/iforce-packets.c 
b/drivers/input/joystick/iforce/iforce-packets.c
index 4a26292..4f8aba7 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -2,7 +2,7 @@
   * $Id: iforce-packets.c,v 1.16 2002/07/07 10:22:50 jdeneux Exp $
   *
   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
diff --git a/drivers/input/joystick/iforce/iforce-serio.c 
b/drivers/input/joystick/iforce/iforce-serio.c
index 64a78c5..eea5dfa 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -2,7 +2,7 @@
   * $Id: iforce-serio.c,v 1.4 2002/01/28 22:45:00 jdeneux Exp $
   *
   *  Copyright (c) 2000-2001 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
diff --git a/drivers/input/joystick/iforce/iforce-usb.c 
b/drivers/input/joystick/iforce/iforce-usb.c
index bc2fce6..9099774 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -2,7 +2,7 @@
   * $Id: iforce-usb.c,v 1.16 2002/06/09 11:08:04 jdeneux Exp $
   *
   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
diff --git a/drivers/input/joystick/iforce/iforce.h 
b/drivers/input/joystick/iforce/iforce.h
index 146f406..0623a8a 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -2,7 +2,7 @@
   * $Id: iforce.h,v 1.13 2002/07/07 10:22:50 jdeneux Exp $
   *
   *  Copyright (c) 2000-2002 Vojtech Pavlik <vojtech@ucw.cz>
- *  Copyright (c) 2001-2002 Johann Deneux <deneux@ifrance.com>
+ *  Copyright (c) 2001-2002 Johann Deneux <johann.deneux@gmail.com>
   *
   *  USB/RS232 I-Force joysticks and wheels.
   */
