Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCEVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCEVuI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCEVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:50:08 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:50566 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261200AbVCEVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:50:00 -0500
Date: Sat, 05 Mar 2005 16:49:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.11.1
In-reply-to: <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051649.58709.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050304175302.GA29289@kroah.com>
 <20050305174654.J3282@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 16:17, Linus Torvalds wrote:
>On Sat, 5 Mar 2005, Russell King wrote:
>> On Sat, Mar 05, 2005 at 09:40:59AM -0800, Linus Torvalds wrote:
>> > I love BK, but what BK does well is merging and maintaining
>> > trees full of good stuff. What BK sucks at is experimental stuff
>> > where you don't know whether something should be eventually used
>> > or not.
>>
>> Wait a minute - why would stuff going into 2.6.x.y be
>> "experimental" stuff?  Wasn't stability the whole point of this
>> tree?
>
>The point being that _before_ a patch gets accepted, it's in that
> "limbo" state, waiting for people to veto it or say "yes".
>
>That limbo state is not well done with BK.
>
>  Linus

What he said!  Perfectly good patches, which fix real problems would 
appear to be sitting in testing/broken_out till bit rot or ???.

If you want a testers testimony, I'm running the bk-ieee1394.patch, 
and all I can say at this point is that it Just Works(TM).  I have 
NDI how it got a yesterdays Mar 4) date in the directory listing 
there though, I've had it a bit longer than that by 2-3 days as my 
copy shows a Mar 1 date.  I first got it via svn fetch at 
linux-ieee1394.org or some such in January.

Fixes for real problems that fix real problems should somehow get a 
faster track into final.  The current firewire in the kernel as of 
2.6.11 is still badly borked.

If that diff in the dates means I should update and retest, please 
advise.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
