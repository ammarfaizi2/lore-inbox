Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUL2AUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUL2AUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUL2AUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:20:53 -0500
Received: from mail.dif.dk ([193.138.115.101]:54717 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261267AbUL2AUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:20:48 -0500
Date: Wed, 29 Dec 2004 01:31:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch] remove bouncing email addr. of Eric van der Maarel from
 drivers/cdrom/isp16.c
Message-ID: <Pine.LNX.4.61.0412290128440.3528@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This tiny patch removes the email address of Eric van der Maarel from 
drivers/cdrom/isp16.c since it bounces. 
It seems better to me that he's just listed with his name than also with a 
useless email address.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/drivers/cdrom/isp16.c linux-2.6.10/drivers/cdrom/isp16.c
--- linux-2.6.10-orig/drivers/cdrom/isp16.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.10/drivers/cdrom/isp16.c	2004-12-29 01:27:26.000000000 +0100
@@ -1,6 +1,6 @@
 /* -- ISP16 cdrom detection and configuration
  *
- *    Copyright (c) 1995,1996 Eric van der Maarel <H.T.M.v.d.Maarel@marin.nl>
+ *    Copyright (c) 1995,1996 Eric van der Maarel
  *
  *    Version 0.6
  *


