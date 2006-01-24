Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWAXV7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWAXV7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWAXV7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:59:13 -0500
Received: from elvira.its.UU.SE ([130.238.164.5]:4012 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S1750764AbWAXV7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:59:12 -0500
Date: Tue, 24 Jan 2006 23:07:07 +0100 (CET)
From: johann.deneux@gmail.com
X-X-Sender: johann@minime.minihome
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] 2.6.16-rc1 Input: HID - email change
Message-ID: <Pine.LNX.4.60.0601242306070.9453@minime.minihome>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changed email address of Johann Deneux (myself).
Clarified comment about the usefulness of this header. This header should 
die if it duplicates some existing fixed point arith, or moved to a place
where all can make use of it.

Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

---
commit 82b3dbf4584205ed7aee044e82616c84753cdc8d
tree 755684edfea7642f6caf6ac58808ea8c52453500
parent 160f2f07187e5cb23c5efc02824e1a6a0ad06e4e
author Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:48:27 +0100
committer Johann Deneux <johann.deneux@gmail.com> Mon, 23 Jan 2006 23:48:27 
+0100

  drivers/usb/input/fixp-arith.h |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/input/fixp-arith.h b/drivers/usb/input/fixp-arith.h
index b44d398..7b6a1ce 100644
--- a/drivers/usb/input/fixp-arith.h
+++ b/drivers/usb/input/fixp-arith.h
@@ -2,10 +2,10 @@
  #define _FIXP_ARITH_H

  /*
- * $$
- *
   * Simplistic fixed-point arithmetics.
- * Hmm, I'm probably duplicating some code :(
+ * Am I duplicating some code for fixed point arithmetics?
+ * If not, this should probably go into include/
+ * If yes, it should die.
   *
   * Copyright (c) 2002 Johann Deneux
   */
@@ -26,7 +26,7 @@
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
   *
   * Should you need to contact me, the author, you can do so by
- * e-mail - mail your message to <deneux@ifrance.com>
+ * e-mail - mail your message to <johann.deneux@gmail.com>
   */

  #include <linux/types.h>
