Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSEYBnm>; Fri, 24 May 2002 21:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSEYBnl>; Fri, 24 May 2002 21:43:41 -0400
Received: from web14206.mail.yahoo.com ([216.136.173.70]:24590 "HELO
	web14206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313182AbSEYBnk>; Fri, 24 May 2002 21:43:40 -0400
Message-ID: <20020525014340.24302.qmail@web14206.mail.yahoo.com>
Date: Fri, 24 May 2002 18:43:40 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Fwd: Re: 2.5.17 Problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Erik McKee <camhanaich99@yahoo.com> wrote:
> From Erik McKee Fri May 24 18:15:20 2002
> Date: Fri, 24 May 2002 18:15:20 -0700 (PDT)
> From: Erik McKee <camhanaich99@yahoo.com>
> Subject: Re: 2.5.17 Problem
> To: Chris Wright <chris@wirex.com>
> 
> Nope...no CONFIG_SMP here ;)
> 
> 
> --- Chris Wright <chris@wirex.com> wrote:
> > * Erik McKee (camhanaich99@yahoo.com) wrote:
> > > Ok, I am becoming a frequent poster here.  Nothing in the logs on this
> one
> > > either.  Left 2.5.17 running overnight on this box which used to be rock
> > solid
> > > unser 2.4.  kde was running, with a screensaver.  On attempting to use
> the
> > box,
> > > mouse mvement did dispell the screensaver.  alt-ctrl-f2 to get to a vc
> > however
> > > left me with a clean black screen.  Nothing worked....alt-sysrq -s or
> > > alt-sysrq-u ddin't produce any disk activity.  alt-sys-rq-b did however
> > reboot
> > > the system.  only issue was unclean raid array afterwards ;)
> > 
> > is this, by chance, a UP machine with:
> > CONFIG_SMP=y
> > CONFIG_PREEMPT=y
> > 
> > i've been seeing regular kernel hangs obtaining the BKL with this
> > configuration.
> > 
> > thanks,
> > -chris
> 
> 
> __________________________________________________
> Do You Yahoo!?
> LAUNCH - Your Yahoo! Music Experience
> http://launch.yahoo.com
> 


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
