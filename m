Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVLGGJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVLGGJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLGGJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:09:01 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:48849 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932540AbVLGGJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:09:00 -0500
Date: Wed, 07 Dec 2005 01:08:58 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <0E093DF2-A72F-4A76-9BF6-8D7E9B1AF31F@mac.com>
To: linux-kernel@vger.kernel.org
Message-id: <200512070108.58466.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512061622.54583.gene.heskett@verizon.net>
 <0E093DF2-A72F-4A76-9BF6-8D7E9B1AF31F@mac.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 00:14, Kyle Moffett wrote:
>On Dec 06, 2005, at 16:22, Gene Heskett wrote:
>> That one installed without any hiccups, but I saw where the sign-on
>> said it was DDR400 dual channel ram, whereas before the update it
>> was DDR333 dual channel ram.  As the XP2800 athlon isn't rated for
>> DDR400, I backed into the bios and reset the fsb for 166 mhz which
>> should give me a 333
>> fsb.  But it still says DDR400 at signon.  So I guess we'll see if
>> its now stable at a 400 mhz fsb even if its set to 166/333.
>
>Hmm, this sounds a lot like the BIOS insanity we saw on one cheapo
>Chaintech board.  We knew it was bad when the thing reported in its
>boot display that the CPU was an "Intel Athlon".  Things only got
>worse from there; but sadly there was no BIOS update, and we ended up
>throwing away the $35 board just on general principles :-D.
>
Thats been my impression of anything wearing a chaintech label, and I 
cannot pin a reason on it, just 71 years of experience.  Is that good 
enough?  Dunno Kyle, but when shopping for a mobo, the chaintech stuff 
has always been bypassed.  Some of the tech reports seem to say they're 
ok though.  Another example of YMMV I guess.

Anyway, I did finally get the bios to stop running the memory faster than 
an XP2800, rated at DDR333 can do.  So after a couple of hard crashes, 
it seems to be back among the living.  I had to use the expert group of 
settings though, & me not an expert, not 50 miles from home, nor am I 
carrying a briefcase as I once heard an expert described.

And, acpi is on, and ntpd is happy with the new bios.  Hurrah!

>Cheers,
>Kyle Moffett
>
>--
>There are two ways of constructing a software design. One way is to
>make it so simple that there are obviously no deficiencies. And the
>other way is to make it so complicated that there are no obvious
>deficiencies.  The first method is far more difficult.
>   -- C.A.R. Hoare

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
