Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbUKVT16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbUKVT16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUKVTYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:24:17 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:25801 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262364AbUKVTV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:21:28 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
Date: Mon, 22 Nov 2004 14:21:27 -0500
User-Agent: KMail/1.7
References: <200411212045.51606.gene.heskett@verizon.net> <200411220721.26712.gene.heskett@verizon.net> <Pine.LNX.4.53.0411222001040.21595@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411222001040.21595@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411221421.27351.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.10.220] at Mon, 22 Nov 2004 13:21:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 14:02, Jan Engelhardt wrote:
>>>>Silly Q of the day probably, but what do I set in a Makefile for
>>>> the -march=option for building on a 233 mhz Pentium 2?
>>>
>>>Now that's really stupid, but here's the answer:
>>>
>>>You run `make menuconfig` (or whichever you like) and choose
>>> Processor Type "Pentium II".
>>
>>If I was building a kernel, then yes my question was stupid.
>>
>>Except I'm not building a kernel, I'm tryng to compile a module to
>>drive some truely dumb hardware, reusing code that was last touched
>>[...]
>
>Well, take a fresh kernel tree, set the desired CPU type, and then
> look at the .config which is generated. Voilà -- in theory ;-)
>
I'm glad you put that caveat in there, Jan. :)

>>Yeah, I'm stupid.  Virtually all of my original C coding has been
>> done on much smaller architectures, and 15 to 20 years ago. 
>> Terminal rust
>
>Never hurts trying to compile a 2.6 for 386SX if the will is strong.
> :-)

On an SX?  No way Jose.  That would take more will power than I have & 
I quit a 2 pack a day habit cold turkey 15+ years ago.  Theres one of 
those things out in a storage shed, won't even run winderz > 95SR1, 
its been tried a couple of times.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
