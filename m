Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269261AbUJWAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269261AbUJWAIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269276AbUJWAG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:06:56 -0400
Received: from holomorphy.com ([207.189.100.168]:30151 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269313AbUJWAEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:04:07 -0400
Date: Fri, 22 Oct 2004 17:04:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023000401.GH17038@holomorphy.com>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
>  Linux-2.6.10-rc1 is out there for your pleasure.
> I thought long and hard about the name of this release (*), since one of
> the main complaints about 2.6.9 was the apparently release naming scheme. 
> Should it be "-rc1"? Or "-pre1" to show it's not really considered release
> quality yet? Or should I make like a rocket scientist, and count _down_
> instead of up? Should I make names based on which day of the week the
> release happened? Questions, questions..
> And the fact is, I can't see the point. I'll just call it all "-rcX",
> because I (very obviously) have no clue where the cut-over-point from
> "pre" to "rc" is, or (even more painfully obviously) where it will become
> the final next release.
> So to not overtax my poor brain, I'll just call them all -rc releases, and
> hope that developers see them as a sign that there's been stuff merged,
> and we should start calming down and seeing to the merged patches being
> stable soon enough..

AFAICT the point is being able to refer to it by name and the only
relevant property of the name is that it's distinct from all others.
This does as well as most any other scheme giving each unique names.
I'd be fine with nightly point releases, though I don't insist.


On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> So without any further ado, here's 2.6.10-rc1 in testing. A fair number of
> patches that were waiting for 2.6.9 to be out are in here, ranging all
> over the map: merges from -mm, network (and net driver) updates, SATA
> stuff, bluetooth, SCSI, device models, janitorial, you name it.
> Oh, and the _real_ name did actually change. It's not Zonked Quokka any 
> more, that's so yesterday. Today we're Woozy Numbat! Get your order in!
> 		Linus
> (*) In other words, I had a beer and watched TV. Mmm... Donuts.

Sounds like a good way to come up with a new name to me. Cheers!


-- wli
