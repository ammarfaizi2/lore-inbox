Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUGBMar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUGBMar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbUGBMar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:30:47 -0400
Received: from gprs214-141.eurotel.cz ([160.218.214.141]:49548 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264402AbUGBMap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:30:45 -0400
Date: Fri, 2 Jul 2004 14:26:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Seifert <thomas-lists@mysnip.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a couple of powernow-k8 questions
Message-ID: <20040702122652.GA15169@elf.ucw.cz>
References: <20040629223328.68eff5e9.thomas-lists@mysnip.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629223328.68eff5e9.thomas-lists@mysnip.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm running an athlon64 3000+ on an epox-mainboard.
> 
> after some bios-upgrades through their support I'm getting at least a bit
> of powernow-support ;)
> 
> Through startup I'm getting these messages now:
> 
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
> powernow-k8: cpu_init done, current fid 0xc, vid 0x2
> ACPI: (supports S0 S1 S4 S5)
> 
> 
> Just to confirm: does that mean only these modes are supported? 
> Wasn't there something down to 800 MHz for the athlon64-processors?

I'd say bios problem. Only AMD people know for sure. 

> Is this a problem of the mainbord (aka still their bios ;)) or of
> the driver?
> Any way to workaround this?

Look into archives for methods how to override.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
