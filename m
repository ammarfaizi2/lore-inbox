Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUC1Tpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUC1Tpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:45:40 -0500
Received: from gprs214-54.eurotel.cz ([160.218.214.54]:42113 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262356AbUC1Tpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:45:38 -0500
Date: Sun, 28 Mar 2004 21:45:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: Martin Wilke <werwolf@unixfreunde.de>, linux-kernel@vger.kernel.org
Subject: Re: Temp problems amd xp
Message-ID: <20040328194527.GB1003@elf.ucw.cz>
References: <pan.2004.03.18.16.06.57.166680@unixfreunde.de> <20040319224243.GG14537@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319224243.GG14537@alpha.home.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > just wanna know if somebody has the same problem as me.
> > 
> > i' m running an amd xp 3000+ on an epox board with nforce2-chipset. everything 
> > was alright til i changeed from kernbel 2.6.3 to 2.6.4 3 days ago. since then 
> > my cpu-temperature rised to 60-65 degrees, sometimes 73 degrees (while 
> > compiling) and pc powered himself down then.
> 
> Is it really a problem ? Simply raise the bios temperature limit and it's
> OK. My dual XP is between 65 and 75 degrees idle, and goes up to 93 during
> intensive compilations, and it's doing very well. Admittedly, you have to
> wait a *very* long time after power down to touch the heatsinks, but I don't
> need to do that anyway, and I prefer the sound of silence ;-)

So you raised thermal limit and disconnected fans? :-).

									Pavel
PS: [With proper passive cooling, you might get away with that. I've
one athlon 900, whose fan now produces noise but not cooling. With
strategically placed piece of paper it produces no noise, but no
cooling either. ACPI thermal managment turns it into +/- usable
machine.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
