Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbULYVd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbULYVd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbULYVd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:33:58 -0500
Received: from mail.dif.dk ([193.138.115.101]:26316 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261572AbULYVd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:33:56 -0500
Date: Sat, 25 Dec 2004 22:44:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: docs: add sparse howto
In-Reply-To: <20041225212235.GA20147@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0412252240000.3495@dragon.hygekrogen.localhost>
References: <20041225212235.GA20147@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2004, Pavel Machek wrote:

> Hi!
> 
> Installing / using sparse is not exactly trivial, this should make
> setting it up easier. Please apply, 
> 								Pavel

/If/ that patch gets accepted may I suggest this companion?   :)

Add sparse.txt to Documentation/00-INDEX

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc3-bk16-orig/Documentation/00-INDEX linux-2.6.10-rc3-bk16/Documentation/00-INDEX
--- linux-2.6.10-rc3-bk16-orig/Documentation/00-INDEX	2004-12-06 22:24:13.000000000 +0100
+++ linux-2.6.10-rc3-bk16/Documentation/00-INDEX	2004-12-25 22:42:34.000000000 +0100
@@ -254,6 +254,8 @@
 	- directory with info on sound card support.
 sparc/
 	- directory with info on using Linux on Sparc architecture.
+sparse.txt
+	- documentation on installing and using the 'sparse' source checker.
 specialix.txt
 	- info on hardware/driver for specialix IO8+ multiport serial card.
 spinlocks.txt


