Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTBPPyk>; Sun, 16 Feb 2003 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTBPPyk>; Sun, 16 Feb 2003 10:54:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15364 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267106AbTBPPxu>;
	Sun, 16 Feb 2003 10:53:50 -0500
Date: Sun, 16 Feb 2003 17:03:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@codemonkey.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq on athlon4
Message-ID: <20030216160306.GC2367@elf.ucw.cz>
References: <20030215221236.GA210@elf.ucw.cz> <20030216144941.GA4459@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216144941.GA4459@codemonkey.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Documentation/cpufreq should probably be renamed to Doc*/cpufreq.txt.
> 
> agreed.
>  
>  > powernow:  cpuid: 0x761 fsb: 100        maxFID: 0xc     startvid: 0xc
>  > powernow:    FID: 0x10 (3.0x [300MHz])  VID: 0xc (1.400V)
>  > powernow:    FID: 0x4 (5.0x [500MHz])   VID: 0xc (1.400V)
>  > powernow:    FID: 0x6 (6.0x [600MHz])   VID: 0xc (1.400V)
>  > powernow:    FID: 0x8 (7.0x [700MHz])   VID: 0xc (1.400V)
>  > powernow:    FID: 0xc (9.0x [900MHz])   VID: 0xc (1.400V)
>  > 
>  > First it claims it can scale voltage, then I see I can only use
>  > 1.4V. Too bad for me (and my batteries ;-)...
> 
> Some laptops have *really* crap PST tables. For the majority, they are
> quite sane.  I'm collecting model names/numbers to feed back to AMD
> so they can go beat up vendors.

Its HP omnibook xe3.

> Its likely at some point I'll implement a way to override using
> the BIOS table too.

So you think that in fact I should be able to run at lower
voltage?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
