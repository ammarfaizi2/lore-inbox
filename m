Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVAKPlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVAKPlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbVAKPlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:41:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:34225 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262800AbVAKPkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:40:45 -0500
Date: Tue, 11 Jan 2005 16:43:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Olaf Kirch <okir@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org, okir@lst.de,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] update bouncing email address of Olaf Kirch in net/sunrpc/auth.c
In-Reply-To: <20050111112201.GC7858@suse.de>
Message-ID: <Pine.LNX.4.61.0501111640110.3368@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501102259090.2987@dragon.hygekrogen.localhost>
 <20050110221522.GA9034@infradead.org> <20050111112201.GC7858@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Olaf Kirch wrote:

> Hi Christoph, Jesper,
> 
> On Mon, Jan 10, 2005 at 10:15:22PM +0000, Christoph Hellwig wrote:
> > > The email address for Olaf Kirch listed in net/sunrpc/auth.c bounces, so 
> > > remove it and leave just the name. He's listed with the same email in 
> > > CREDITS, should the address stay or would a patch to remove it there as 
> > > well be appreciated?  I've been unable to find a working address for him 
> > > (if someone knows of one, then changing the address would probably be 
> > > better), and it doesn't seem logical to keep bouncing addresses around.  
> > > What's the general opinion on this?
> > 
> > He's reachable as okir@lst.de and okir@suse.de at least
> 
> Yes, indeed. Changing my email in the Credits file to my @suse.de
> address is appreciated; feel free to remove the old monad.swb.de
> address.
> 
Ok, here's an updated patch for net/sunrpc/auth.c 


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk

diff -u linux-2.6.10-bk13-orig/net/sunrpc/auth.c linux-2.6.10-bk13/net/sunrpc/auth.c
--- linux-2.6.10-bk13-orig/net/sunrpc/auth.c	2005-01-10 22:09:22.000000000 +0100
+++ linux-2.6.10-bk13/net/sunrpc/auth.c	2005-01-11 16:38:28.000000000 +0100
@@ -3,7 +3,7 @@
  *
  * Generic RPC client authentication API.
  *
- * Copyright (C) 1996, Olaf Kirch <okir@monad.swb.de>
+ * Copyright (C) 1996, Olaf Kirch <okir@suse.de>
  */
 
 #include <linux/types.h>


