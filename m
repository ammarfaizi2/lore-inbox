Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUI0QGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUI0QGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUI0QGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:06:08 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:57991 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S266578AbUI0QGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:06:03 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, lkml@lpbproductions.com
Subject: Re: 2.6.9-rc2-mm4
Date: Mon, 27 Sep 2004 12:06:01 -0400
User-Agent: KMail/1.7
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409271131.27329.gene.heskett@verizon.net> <200409270852.44366.lkml@lpbproductions.com>
In-Reply-To: <200409270852.44366.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409271206.01753.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.153.74.116] at Mon, 27 Sep 2004 11:06:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2004 11:52, Matt Heler wrote:
>On Monday 27 September 2004 8:31 am, Gene Heskett wrote:
>> ones to be effected, so lets compare notes:
>>
>> AMD Athlon 2800xp, biostar N7-NCD-Pro motherboard with an nforce2
>> chipset, and using the forcedeth driver for eth0.  A gigabyte of
>> DDR400 rated ram running in DDR333 dual channel mode, the 2800xp
>> Athlon can't handle the DDR400 fsb correctly. No acpi is enabled,
>> and apm only for shutdown control & rtc handling.
>
>Simular system here. Athlon 3000xp , with nforce2 chipset.

Can your athlon 3000xp do the DDR400 setting for the fsb?

For all the marketing hoopla, this 2800 is nowhere near twice as fast 
the 1400xp it replaced, the 1400 was doing about 4.5 units of seti 
per day, and this one is normally doing about 7.1.  I expected to see 
about 9/day.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
