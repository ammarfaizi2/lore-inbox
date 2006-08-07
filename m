Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWHGXkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWHGXkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHGXkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:40:41 -0400
Received: from xenotime.net ([66.160.160.81]:44229 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932401AbWHGXkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:40:41 -0400
Date: Mon, 7 Aug 2006 16:43:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Pavel Machek <pavel@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Paul.Clements@steeleye.com
Subject: Re: [PATCH -mm 1/5] nbd: printk format warning
Message-Id: <20060807164323.22bd24eb.rdunlap@xenotime.net>
In-Reply-To: <20060807233151.GJ2759@elf.ucw.cz>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
	<20060807230726.GA2724@elf.ucw.cz>
	<20060807163147.547b6861.rdunlap@xenotime.net>
	<20060807233151.GJ2759@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 01:31:51 +0200 Pavel Machek wrote:

> On Mon 2006-08-07 16:31:47, Randy.Dunlap wrote:
> > On Tue, 8 Aug 2006 01:07:26 +0200 Pavel Machek wrote:
> > 
> > > Hi!
> > > 
> > > > Fix printk format warning(s):
> > > > drivers/block/nbd.c:410: warning: long unsigned int format, different type arg (arg 4)
> > > > 
> > > 
> > > ACK, but notice that we have new nbd maintainer... for a few years
> > > now.
> > 
> > Please notice that I could not find that info in either of
> > MAINTAINERS or CREDITS.... :(
> > 
> > Please have him/her send a patch.
> 
> No, I think you can push the patch, or make it go through akpm.
> 
> It is in maintainers, but perhaps we need to add (NBD) there to help
> grep?

OK, yes, sorry about that.  I did grep for /NBD/.  :)

> NETWORK BLOCK DEVICE
> P:      Paul Clements
> M:      Paul.Clements@steeleye.com
> S:      Maintained


---
~Randy
