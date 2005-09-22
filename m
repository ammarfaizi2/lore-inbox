Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVIVSIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVIVSIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVIVSIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:08:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55755 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750873AbVIVSId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:08:33 -0400
Date: Thu, 22 Sep 2005 19:08:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922180816.GA2041@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
	Joshua Kwan <joshk@triplehelix.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <1127398679.18840.84.camel@localhost.localdomain> <20050922135607.GK4262@suse.de> <1127399409.18840.95.camel@localhost.localdomain> <4332F085.9060909@pobox.com> <Pine.LNX.4.58.0509221103230.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509221103230.2553@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 11:04:58AM -0700, Linus Torvalds wrote:
> Why not just send it to me and Andrew and get it merged.
> 
> The way we keep everybody honest (me, maintainers, and random developers) 
> is with this concept called "open source", which means that anybody can 
> fix a problem, and you don't need to wait for the "vendor". 
> 
> Yes, it's good to go through channels, but when that doesn't work, it's 
> good to go _past_ them too.

Umm, no one tried.  The last time it came up there was a healthy
discussion, but it stopped somewhere and no one followed up.  There
were two sets of patches from Jens and James and we need to arrive
somewhere in the middle.

That's exactly what I said above, people should stop bitching and bring
the patch up again - I'm pretty sure we'll find an acceptable variant
real soon.

