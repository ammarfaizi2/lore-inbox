Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266899AbUG1MwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266899AbUG1MwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUG1MwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:52:15 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:12445 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S266899AbUG1MwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:52:06 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Wed, 28 Jul 2004 08:52:04 -0400
User-Agent: KMail/1.6.82
References: <200407271233.04205.gene.heskett@verizon.net> <200407280720.21518.gene.heskett@verizon.net> <10D3E6305A14470B62191D9B@sig-9-145-17-80.uk.ibm.com>
In-Reply-To: <10D3E6305A14470B62191D9B@sig-9-145-17-80.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407280852.04763.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [141.153.76.84] at Wed, 28 Jul 2004 07:52:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 July 2004 07:38, Andy Whitcroft wrote:
>> I just had another crash/lockup, running 2.6.8-rc2-bk3
>> At the instant, I was looking thru the menu's of the new
>> kde3.3-beta2, in the window decoration, themes etc menu,
>> where it got 14% loaded in a 60 megabyte file and it went
>> away.
>
>Confused.  Previously (below) you were running 2.6.8-rc2 so the
> problem was in that version but not in -rc1 if I read you
> correctly.  So I would expect you to be testing 2.6.8-rc1-bkN
> snapshots to see where your breakage was introduced.

I was having mobo problems back about rc1 times, so I'm not able to 
positively say that rc1 did/did not do it.  I tried to make that 
clear in a later message but must not have been.  Motherboard, cpu, 
memory and psu are all fresh now.

As this mobo contains the nforce2 chipset, now running the reverse 
engineered driver, how far back can I go without running into 
problems with it?

>> I have now had 4 crashes while running 2.6.8-rc2, the last one
>> requiring a full powerdown before the intel-8x0 could
>> re-establish control over the sound.
>
>[...]
>
>> I'd revert to rc1, but I'd have to figure out a way to use this
>> .config
>
>As viro put it:
>>It goes like that:
>>2.6.7
>>2.6.7 + 7-bk<n>
>>2.6.7 + 8-rc1
>>2.6.7 + 8-rc1 + 8-rc1-bk<n>
>>2.6.7 + 8-rc2
>>2.6.7 + 8-rc2 + 8-rc2-bk<n>
>
>-apw

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.23% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
