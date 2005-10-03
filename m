Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVJCDvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVJCDvF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 23:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVJCDvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 23:51:05 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:60293 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932135AbVJCDvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 23:51:04 -0400
Date: Sun, 02 Oct 2005 23:50:54 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: what's next for the linux kernel?
In-reply-to: <Pine.LNX.4.63.0510021948180.27456@cuia.boston.redhat.com>
To: linux-kernel@vger.kernel.org
Message-id: <200510022350.54640.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it>
 <200510021932.00969.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0510021948180.27456@cuia.boston.redhat.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 October 2005 19:48, Rik van Riel wrote:
>On Sun, 2 Oct 2005, Gene Heskett wrote:
>> Ahh, yes and no, Robert.  The un-answered question, for that
>> 512 processor Altix system, would be "but does it run things 512
>> times faster?"  Methinks not, by a very wide margin.  Yes, do a lot
>> of unrelated things fast maybe, but render a 30 megabyte page with
>> ghostscript in 10 milliseconds?  Never happen IMO.
>
>You haven't explained us why you think your proposal
>would allow Linux to circumvent Amdahl's law...

Amdahl's Law?

Thats a reference I don't believe I've been made aware of.  Can you
elaborate?
  
Besides, it isn't my proposal, just a question in that I chose a
scenario (ghostscripts rendering of a page of text) that in fact only
runs maybe 10x faster on an XP-2800 Athlon with a gig of dram than it
did on my old 25 mhz 68040 equipt amiga with 64 megs of dram.  
With 64 megs of dram, so it wasn't nearly as memory bound doing that
as most of the Amiga's were.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

