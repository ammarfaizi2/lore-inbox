Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSK0Jbh>; Wed, 27 Nov 2002 04:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSK0Jbh>; Wed, 27 Nov 2002 04:31:37 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:57083 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261836AbSK0Jbg>; Wed, 27 Nov 2002 04:31:36 -0500
Date: Wed, 27 Nov 2002 01:39:05 -0800
From: Joshua Kwan <joshk@mspencer.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Message-Id: <20021127013905.23642db3.joshk@mspencer.net>
In-Reply-To: <200211270939.38410.m.c.p@wolk-project.de>
References: <200211270939.38410.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.8.6cvs7 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some additional information - DRI would refuse to work in aforementioned versions of the -ac branch.
I had to reboot to -rc2-ac2 to play Quake III Arena in hardware mode, so I think i'll stick with it until Arjan manages to iron out the bugs. :D

Regards
-Josh

Rabid cheeseburgers forced Marc-Christian Petersen <m.c.p@wolk-project.de> to write this on Wed, 27 Nov 2002 09:39:38 +0100:	

> Hi Joshua,
> 
> > Ksymoops output follows.
> > I compiled Radeon DRM stuff into the kernel -- i845 agp support from 
> > agapgart. I am using gcc-3.2 to compile. 100% reproducible (okay, i've been
> > spending too much time on bugzillas...) Feel the power of the oops.
> 
> I've posted a similar oops with latest rc2 -AC kernel. I have an ATI Rage128 
> card and also got those oops if using DRI.
> 
> I hope Arjan may find the bug :)
> 
> ciao, Marc
