Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSGCQrm>; Wed, 3 Jul 2002 12:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSGCQrl>; Wed, 3 Jul 2002 12:47:41 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:48605 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317176AbSGCQri>; Wed, 3 Jul 2002 12:47:38 -0400
Date: Wed, 3 Jul 2002 05:06:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2: APM & ACPI
Message-ID: <20020703030610.GD474@elf.ucw.cz>
References: <1024959550.3208.11.camel@nomade> <200206251436.57940.snowwolf@one2one-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206251436.57940.snowwolf@one2one-networks.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That's weird, because I left apm only to power off the machine
> > (otherwise it doesn't), knowing that it wouldn't be enabled because of
> > the SMP mobo. ACPI should still work.
> >
> > (OTOH, I finally disabled ACPI because (after compiling without APM) it
> > appears it randomly freezes or reboots my machine ..)
> >
> Havent you heard? Thats what ACPI-support does on linux ;-)
> 
> So power off your SMP manually or accumulate uptime like the rest of us.
> 
> (actually ACPI is more stable om SMP machines that normal ones. My ASUS A7M-D 
> dual Athlon is the only machine I have ever seen survive more than 5 minutes 
> with an ACPI-kernel)

My machines can actually stay up longer than 5 minutes, even with acpi
enabled... Have you tried 2.5.latest?
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
