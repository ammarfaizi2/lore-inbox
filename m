Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272764AbTG3For (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272765AbTG3For
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:44:47 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:44192 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP id S272764AbTG3Fop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:44:45 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Ville Herva <vherva@niksula.hut.fi>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: Turning off automatic screen clanking
Date: Wed, 30 Jul 2003 01:44:40 -0400
User-Agent: KMail/1.5.1
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730052213.GU150921@niksula.cs.hut.fi>
In-Reply-To: <20030730052213.GU150921@niksula.cs.hut.fi>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307300144.40691.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [151.205.10.84] at Wed, 30 Jul 2003 00:44:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 July 2003 01:22, Ville Herva wrote:
>On Tue, Jul 29, 2003 at 08:17:15PM -0400, you [Zwane Mwaikambo] 
wrote:
>> On Tue, 29 Jul 2003, Richard B. Johnson wrote:
>> > If the machine had blanking disabled by default, then the
>> > usual SYS-V startup scripts could execute setterm to enable
>> > it IFF it was wanted.
>>
>> optimise for the common case,
>
>I would argue the other way around. The majority of desktop users
> run X, console blanking won't help them anyway. The server users
> tend to have KVM or switch monitor cables on the fly - in most such
> cases console blanking hurts more than helps (since you can't tell
> which box is connected to which monitor etc.)
>
>And console blanking is not real DPMS power save anyway.
>
>> just fix your box and be done with it.
>
>Most times when you need to have it fixed is when your box has
> mysteriously locked up, and you'd wan't to know if there was a oops
> on the screen. No can do - the console is already blanked. By then
> it is too late to fix it.
>
>In what cases is console blanking so hugely important these days,
> anyway?

I feel like I should concur here, as console blanking has bit me more 
than once.  A compile time option, grub/lilo append, whatever, but in 
any event it should be unconditionally disableable if one so chooses.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

