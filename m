Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbULORMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbULORMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbULORMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:12:24 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:25822 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262398AbULORMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:12:18 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: realtime preempt 2.6.10-rc3-mm1-V0.33-0
Date: Wed, 15 Dec 2004 12:12:17 -0500
User-Agent: KMail/1.7
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
References: <200412141123.02293.gene.heskett@verizon.net> <41C032E5.3060404@stud.feec.vutbr.cz>
In-Reply-To: <41C032E5.3060404@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151212.17243.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 11:12:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 07:49, Michal Schmidt wrote:
>Gene Heskett wrote:
>> Q: Where have the 'nv' drivers gone in the make xconfig display?
>> I just bought a Chaintech Gforce 5200 and cannot find the driver
>> in the menu so I can make the module.
>
>It was never in the kernel. The 'nv' driver is a part of
> XFree86/X.org.
>
>Michal

Yes, I was rather pleasantly surprised to see my BDI install boot to
X just fine with nothing more than plugging in the card and setting
the bios to AGP first.  But I haven't tried the FC3RC3 install to see
if it boots yet, its secondary to what this machine is intended to do.

Unforch, the mouse, which I also changed from a ps2 GE optical to a
USB optical logitek, is not being found by the xserver so it bails
out.

Thats a debian/morphix based release, does anyone know the inittab
setting for a non x boot with full facilities?, I'm confused, too many
years of redhat experience :(

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

