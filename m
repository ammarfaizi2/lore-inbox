Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281530AbRKPUO0>; Fri, 16 Nov 2001 15:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281532AbRKPUOQ>; Fri, 16 Nov 2001 15:14:16 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2432 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S281530AbRKPUN7>;
	Fri, 16 Nov 2001 15:13:59 -0500
Date: Fri, 16 Nov 2001 10:30:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Daniel_Schr=F6ter?= <d.schroeter@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pressing no Key on Keyboard --> Linux hangs if switching of the monitor
Message-ID: <20011116103028.A38@toy.ucw.cz>
In-Reply-To: <3BF23873.4020902@gmx.de> <3BF42798.1050204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BF42798.1050204@gmx.de>; from d.schroeter@gmx.de on Thu, Nov 15, 2001 at 09:37:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

>  > it works in 2.4.9 (and earlier) (with a littel other .config, I'll
>  > try it soon with  the same).
> Okay. I tried it. I build the 2.4.9 Kernel with the same .config like 
> the 2.4.15-pre4 (ACPI was also switched off): It doesn't crash! The 
> monitor switched off normal and the system works anymore.
> 
> Does anybody have a solution? What should I try next?

turn on/off apm? if it does not help, do binary search which option
causes that.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

