Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUD3VHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUD3VHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUD3VGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:06:45 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:20422 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261186AbUD3VDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:03:47 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Timothy Miller <miller@techsource.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 17:03:44 -0400
User-Agent: KMail/1.6
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Paul Wagland <paul@wagland.net>,
       Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>,
       Marc Boucher <marc@linuxant.com>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <40923D65.2010704@aitel.hist.no> <40927CC5.7060901@techsource.com>
In-Reply-To: <40927CC5.7060901@techsource.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404301703.44551.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.153.75.83] at Fri, 30 Apr 2004 16:03:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 12:20, Timothy Miller wrote:
>Helge Hafting wrote:
>> Timothy Miller wrote:
>>> While we're on all of this, are we going to change "tained" to
>>> some other less alarmist word?  Say there is a /proc file or some
>>> report that you can generate about the kernel that simply wants
>>> to indicate that the kernel contains closed-source modules, and
>>> we want to use a short, concise word like "tainted" for this. 
>>> "An untrusted module has been loaded into this kernel" would be
>>> just a bit too long to qualify.
>>>
>>> Hmmm... how about "untrusted"?  Not sure...
>>
>> "Unsupported" seems a good candidate to me.  It describes the
>> situation fairly well.  Such a kernel is unsupported by the
>> kernel community, and probably by the binary module vendor
>> too. They tend to restrict support to their own module . . .
>
>GOOD!  And if people misunderstood "unsupported" to also mean that
> the VENDOR doesn't support it either, that's fine, because it's
> almost always true.  :)
>
I'm on this side of the fence too.  There are some vendors whose gear 
I will not knowingly buy, memorex being one of them after I got a 
device damaged by a power surge from nearby lightning, and was 
summarily told by the telephone support dweebs that they did NOT 
support linux, and that my warranty was worthless if it was ever 
hooked to a linux box.  Hieing myself back to the dealer, he tried it 
on a windows box, and it indeed was broken as far as the passthru was 
concerned, but it almost made a picture so that was good enough for 
them and I was told to go piss up a rope.

We should, and really, no dis-respect for Marc is intended here, 
demand that the drivers furnished for linux be 100% open source.

I have an nvidia card, but run the nv driver for exactly that reason.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
