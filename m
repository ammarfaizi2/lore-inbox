Return-Path: <linux-kernel-owner+w=401wt.eu-S1161036AbWLPPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWLPPPS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWLPPPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:15:18 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:44173 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161036AbWLPPPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:15:16 -0500
Date: Sat, 16 Dec 2006 10:15:08 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for
 2.6.19]
In-reply-to: <200612161128.27721.rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Willy Tarreau <w@1wt.eu>,
       Linus Torvalds <torvalds@osdl.org>, karderio <karderio@gmail.com>
Message-id: <200612161015.08355.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1166226982.12721.78.camel@localhost>
 <20061216064344.GF24090@1wt.eu> <200612161128.27721.rjw@sisk.pl>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 05:28, Rafael J. Wysocki wrote:
>On Saturday, 16 December 2006 07:43, Willy Tarreau wrote:
[...]
>I think the most important problem with the binary-only drivers is that
> we can't support their users _at_ _all_, but some of them expect us to
> support them somehow.
>
>So, why don't we make an official statement, like something that will
> appear on the front page of www.kernel.org, that the users of
> binary-only drivers will never get any support from us?  That would
> make things crystal clear.
>
>Greetings,
>Rafael

I disagree with this, to the extent that I perceive this business of no 
support for a 'tainted' kernel to be almost in the same category as 
saying that if we configure and build our own kernels, then we are alone 
and you don't want to hear about it.

Yes, there is a rather large difference in actual fact, but if I come to 
the list with a firewire or usb problem, we should be capable of 
divorcing the fact that I may also be using an ati or nvidia supplied 
driver from the firewire or usb problem at hand.

I am not in fact using the ati driver with my 9200SE, as the in-kernel as 
its plenty good enough for that I do, but that's the point.  To 
automaticly deny supplying what might be helpfull suggestions just 
because the user has a 'tainted' kernel strikes me as being pretty darned 
hypocritical, particularly when the user states he has reverted but this 
instant problem persists.

Yes, there have been bad drivers, but they are generally rather quickly 
known about, and replaced with newer versions in short order if problems 
of a fixed pattern are known to occur with version xyz of the nvidia 
stuff.

small rant:
Ati's track record is not so stellar in terms of timely fixes, but from 
comments I see, their support may be getting better, but IMO the main 
support we see is from their PR people announcing yet another linux 
driver project we rarely see the output of while the card itself is still 
in production.  I've been burnt there, twice now, once I even bought 
linux drivers from a 3rd party & took a bath on that too, wanting to use 
such and such a card, waiting till we had a driver for that card, then 
going after the card only to find it doesn't work, they've replaced the 
card with a new, completely incompatible version without changing 
anything on the box, and only the windows cd and the actual card in the 
box.  That's just plain criminal, that box should be carrying at least a 
new part number so the buyer can make an intelligent choice.

/rant

But those are *my* problems and I'm a big boy now.  I just want to point 
out that this 'tainted' business, while 90% politically driven, is a huge 
turnoff for the Joe Sixpacks looking to get the M$ shaft out of an 
orifice normally used for other things.

I also have witnessed more of this argument, which seems to occur at 
monthly intervals, than I care to.  This is not productive use of anyones 
time.  And I've now contributed to the noise so I'll SU...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
