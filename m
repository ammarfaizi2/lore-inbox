Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWHGXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHGXcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWHGXcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:32:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26324 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932415AbWHGXcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:32:06 -0400
Date: Tue, 8 Aug 2006 01:31:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Paul.Clements@steeleye.com
Subject: Re: [PATCH -mm 1/5] nbd: printk format warning
Message-ID: <20060807233151.GJ2759@elf.ucw.cz>
References: <20060807154750.5a268055.rdunlap@xenotime.net> <20060807230726.GA2724@elf.ucw.cz> <20060807163147.547b6861.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807163147.547b6861.rdunlap@xenotime.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-08-07 16:31:47, Randy.Dunlap wrote:
> On Tue, 8 Aug 2006 01:07:26 +0200 Pavel Machek wrote:
> 
> > Hi!
> > 
> > > Fix printk format warning(s):
> > > drivers/block/nbd.c:410: warning: long unsigned int format, different type arg (arg 4)
> > > 
> > 
> > ACK, but notice that we have new nbd maintainer... for a few years
> > now.
> 
> Please notice that I could not find that info in either of
> MAINTAINERS or CREDITS.... :(
> 
> Please have him/her send a patch.

No, I think you can push the patch, or make it go through akpm.

It is in maintainers, but perhaps we need to add (NBD) there to help
grep?

NETWORK BLOCK DEVICE
P:      Paul Clements
M:      Paul.Clements@steeleye.com
S:      Maintained


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
