Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTIAHvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIAHvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:51:35 -0400
Received: from imap.gmx.net ([213.165.64.20]:58780 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262373AbTIAHv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:51:27 -0400
From: "Christian Ludwig" <cl81@gmx.net>
To: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
Subject: [TYPO] linux-2.6.0-test4 - in atkbd
Date: Mon, 1 Sep 2003 09:53:02 +0200
Message-ID: <000101c3705e$130d47a0$1c6fa8c0@hyper>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I don't know if anyone already submitted this, but here it is (probably
again).
Just a simple typo fix. It's against linux-2.6.0-test4
Please apply.

Have fun,
	Christian


atkbd_typo.patch:

--- linux/drivers/input/keyboard/atkbd.c~typo	2003-06-22
20:33:08.000000000 +0200
+++ linux/drivers/input/keyboard/atkbd.c	2003-09-01
09:38:25.000000000 +0200
@@ -477,7 +477,7 @@
 }
 
 /*
- * atkbd_connect() is called when the serio module finds and interface
+ * atkbd_connect() is called when the serio module finds an interface
  * that isn't handled yet by an appropriate device driver. We check if
  * there is an AT keyboard out there and if yes, we register ourselves
  * to the input module.

