Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVAKPnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVAKPnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVAKPnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:43:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:38578 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262803AbVAKPmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:42:55 -0500
Date: Tue, 11 Jan 2005 16:45:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Olaf Kirch <okir@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org, okir@lst.de,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] update bouncing email address of Olaf Kirch in CREDITS
In-Reply-To: <20050111112201.GC7858@suse.de>
Message-ID: <Pine.LNX.4.61.0501111643510.3368@dragon.hygekrogen.localhost>
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
Here's a patch to update the email address in CREDITS


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-bk13-orig/CREDITS linux-2.6.10-bk13/CREDITS
--- linux-2.6.10-bk13-orig/CREDITS	2005-01-10 22:08:48.000000000 +0100
+++ linux-2.6.10-bk13/CREDITS	2005-01-11 16:38:49.000000000 +0100
@@ -1707,7 +1707,7 @@
 S: England
 
 N: Olaf Kirch
-E: okir@monad.swb.de
+E: okir@suse.de
 D: Author of the Linux Network Administrators' Guide
 S: Kattreinstr 38
 S: D-64295



