Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVHORBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVHORBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbVHORBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:01:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6161 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964847AbVHORBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:01:20 -0400
Date: Mon, 15 Aug 2005 18:35:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Adrian Bunk <bunk@stusta.de>, Blaisorblade <blaisorblade@yahoo.it>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Feature removal: ACPI S4bios support
Message-ID: <20050815163520.GG20363@alpha.home.local>
References: <200508111417.47499.blaisorblade@yahoo.it> <20050812132444.GH1826@elf.ucw.cz> <20050815160007.GA3614@stusta.de> <20050815162638.GA2379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815162638.GA2379@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Mon, Aug 15, 2005 at 06:26:38PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Remove S4BIOS support. It is pretty useless, and only ever worked for
> > > _me_ once. (I do not think anyone else ever tried it). It was in
> > > feature-removal for a long time, and it should have been removed before.
> > >...
> > 
> > You've forgotten to remove the feature-removal-schedule.txt entry in 
> > your patch.  ;-)
> 
> Well, that can always be done later. There are probably other small
> pieces that can be removed now. But I got neither ACK nor NAK on the
> patch :-(.

Oh, it's a good sign. There are so many people loudly complaining when a
feature is removed (including me). That means you found nobody to disagree
with you. The fact that nobody either ACKed your patch may be because nobody
is able to tell better than you if it will break anything. Maybe it's time
to repost and ask for an ACK ?

> 								Pavel

Willy

> -- 
> if you have sharp zaurus hardware you don't need... you know my address
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
