Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265008AbUDUGVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265008AbUDUGVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUDUGHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:07:54 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:36524 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264984AbUDUGFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/15] New set of input patches: lkkbd whitespace
Date: Wed, 21 Apr 2004 00:52:25 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210052.28755.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1905, 2004-04-20 22:25:18-05:00, dtor_core@ameritech.net
  Input: fix spelling and trailing whitespaces in lkkbd


 lkkbd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
--- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
+++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
@@ -12,7 +12,7 @@
  * adaptor).
  *
  * DISCLAUNER: This works for _me_. If you break anything by using the
- * information given below, I will _not_ be lieable!
+ * information given below, I will _not_ be liable!
  *
  * RJ11 pinout:		To DB9:		Or DB25:
  * 	1 - RxD <---->	Pin 3 (TxD) <->	Pin 2 (TxD)
@@ -39,18 +39,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * email or by paper mail:
  * Jan-Benedict Glaw, Lilienstra??e 16, 33790 H??rste (near Halle/Westf.),
