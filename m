Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbULMPBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbULMPBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULMPBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:01:53 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:9107 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261230AbULMPBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:01:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 vs clock
Date: Mon, 13 Dec 2004 10:01:32 -0500
User-Agent: KMail/1.7
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, David Weinehall <tao@debian.org>
References: <200412041111.16055.gene.heskett@verizon.net> <20041213122925.GT27718@khan.acc.umu.se> <200412131504.43239.rjw@sisk.pl>
In-Reply-To: <200412131504.43239.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412131001.32695.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.42.94] at Mon, 13 Dec 2004 09:01:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 December 2004 09:04, Rafael J. Wysocki wrote:
>On Monday 13 of December 2004 13:29, David Weinehall wrote:
>> On Sat, Dec 04, 2004 at 11:11:16AM -0500, Gene Heskett wrote:
>> > At -rc2 my clock kept fairly decent time, but -rc3 is running
>> > fast, about 30 seconds an hour fast.
>>
>> Lucky you. Each time I suspend my laptop the clock speeds up
>> approximately x2...  Usually, the time it takes me to get from
>> home to work means that the computer tells me I arrived half an
>> hour late...
>
>I see something strange that may be related to these issues.  When I
> turn off my box and turn it on again after a couple of hours, and
> run Linux, the clock is apparently late, although it shows the
> right time in the CMOS setup right before booting the kernel.  The
> amount of time the clock is late (in Linux) depends on how much
> time the box has been off (it increases about 4 min. for each hour,
> so the clock is about 30 min. late if the box has been off for 8
> hours).
>
>This has been present on all kernels since 2.6.8 at least (I did not
> run earlier kernels on this box), but I haven't tried
> 2.6.10-rc3-mm1 yet.

This is not something I've noted, but then this box is only shut off
to blow the dirt out and clean & regrease the flower on the cpu at
about 6 month intervals.

>> > I've been using ntpdate, is that now officially deprecated?
>>
>> I kind of doubt that...
>
>Me too. ;-)
>
>Greets,
>RJW

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

