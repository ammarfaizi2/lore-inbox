Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRDAJsX>; Sun, 1 Apr 2001 05:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132112AbRDAJsO>; Sun, 1 Apr 2001 05:48:14 -0400
Received: from Campbell.cwx.net ([216.17.176.12]:40717 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S132110AbRDAJr7>;
	Sun, 1 Apr 2001 05:47:59 -0400
Date: Sun, 1 Apr 2001 03:47:04 -0600
From: Allen Campbell <lkml@campbell.cwx.net>
To: Simon Garner <sgarner@expio.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Message-ID: <20010401034704.A97117@const.>
In-Reply-To: <004801c0ba62$6cd67810$1400a8c0@expio.net.nz> <20010331221319.A95411@const.> <00a401c0ba8c$c54efdd0$1400a8c0@expio.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00a401c0ba8c$c54efdd0$1400a8c0@expio.net.nz>; from sgarner@expio.co.nz on Sun, Apr 01, 2001 at 09:18:25PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2001 at 09:18:25PM +1200, Simon Garner wrote:
> From: "Allen Campbell" <lkml@campbell.cwx.net>
> 
> > I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> > 2.4.2 (debian woody).  In addition, the kernel would sometimes hang
> > around NMI watchdog enable.  At least, I think it's trying to
> > `enable'.  The hang would occur around 50% of boot attempts.  Once
> > booted, everything was stable.  A non-SMP 2.4.2 kernel (no IO-APIC
> > either, sorry, didn't test that) always booted without hangs.
> 
> Yep, sounds like the same problem.
> 
> 
> >
> > Strangely, (happily for me,) the boot hangs stopped with 2.4.3.
> > I've booted maybe 10 times (hot and cold) since I built 2.4.3 and
> > I've had no hangs.  When I get back to the box, I'll try booting
> > a few dozen more times and see if I can confirm your observation.
> >
> 
> Please do test it. I think you'll find the problem is still very much
> present.

Yeah, still there.  Cold boot only.
