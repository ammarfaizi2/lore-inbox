Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUDGQRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbUDGQRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:17:30 -0400
Received: from bender.bawue.de ([193.7.176.20]:32660 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263729AbUDGQRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:17:11 -0400
Date: Wed, 7 Apr 2004 18:17:03 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
Message-ID: <20040407161703.GA3550@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Gene Heskett <gene.heskett@verizon.net>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040406193649.GA13257@sommrey.de> <200404061626.37714.gene.heskett@verizon.net> <20040406204545.GA15946@sommrey.de> <200404061757.54779.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404061757.54779.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 05:57:54PM -0400, Gene Heskett wrote:
> >That's not quite my point.  I am not afraid of running my athlons at
> >70C.  I just don't want to.  With Debian Woody they ran at <40C,
> > which is impressing IMHO.  An upgrade to Sarge raised the temp for
> > about 5K, which is still very cool.  This temperature didn't change
> > when I upgraded to an early 2.6 kernel.  Just after 2.6.3-mm4 there
> > was this jump for 10K that I just do not understand.  It doesn't
> > hurt the athlons but seems unnecessary to me.
> >
> >-jo
> 
> 40C?  Shut down for an hour to cool, I've never seen the post on my 
> board show less than 63C by the time it gets to that part of the 
> bios.  I'm running a 1400DX at 1400mhz, so the bios thinks its a 
> 1600DX, and I've got vcore set down to 1.65 volts which helps a bit.
Do you use anything besides a fan to keep your processors cool?  I've no
experience with athlons on UP machines, but amd76x_pm does a good job on
MPs.  I'm not joking: lmsensors sometimes reports 38C on low load.
> 
> Actually, the athlons seem to have a builtin shutdown at 75C, I've hit 
> that once or 3 times when the air under the desk was trapped worse 
> than usual.  Makes for downright ugly reboots...
Seems like athlon 2000+ MPs are more robust.  Playing cube rises
temperature to 78C without any problems.

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-04-07 18:02 /home/jo/.signature
