Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbRE0Qgl>; Sun, 27 May 2001 12:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbRE0Qgb>; Sun, 27 May 2001 12:36:31 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:20996 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S262817AbRE0QgX>;
	Sun, 27 May 2001 12:36:23 -0400
Message-ID: <20010527182730.A19341@bug.ucw.cz>
Date: Sun, 27 May 2001 18:27:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg Banks <gnb@alphalink.com.au>,
        Jaswinder Singh <jaswinder.singh@3disystems.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <E153pEG-0008RL-00@the-village.bc.nu> <01ce01c0e64c$b6cc01e0$52a6b3d0@Toshiba> <3B1061FC.EB18967A@alphalink.com.au> <029901c0e652$a108f740$52a6b3d0@Toshiba> <3B106BE6.78F9DCC4@alphalink.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B106BE6.78F9DCC4@alphalink.com.au>; from Greg Banks on Sun, May 27, 2001 at 12:52:22PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >   I have some code which could become the basis for such a thing.
> > > It's a touch panel driver for the DMIDA but it also has a device-
> > > independent layer which does supersampling, scaling, provides
> > > raw and cooked Linux Input interfaces, and a /proc interface to
> > > allow the calibration app to control the scaling.
> > >
> > >   Unfortunately I can't release it yet for (ahem) legal reasons.
> > >
> > 
> > nice job , from where you get the related specs ?
> 
>   From the manufacturer.  We had the fullest possible co-operation
> including all technical specs, several sample machines, source to
> the WinCE drivers for the hardware, and engineers (including the lead
> hardware designer, a *very* cluey gentleman) on standby to answer
> questions.

Nice, *very* nice. What manufacturer / machine is that?
								Pavel
PS: If someone wants to develop, pr31700-based machines are pretty
well documented, because 99% of functionality comes from two core
chips, and they are documented.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
