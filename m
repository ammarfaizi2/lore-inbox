Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSLPOAv>; Mon, 16 Dec 2002 09:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLPOAv>; Mon, 16 Dec 2002 09:00:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23433 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265612AbSLPOAu>; Mon, 16 Dec 2002 09:00:50 -0500
Date: Mon, 16 Dec 2002 09:10:30 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Jackson <brian-kernel-list@mdrx.com>
cc: Scott Robert Ladd <scott@coyotegulch.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo and hyperthreading
In-Reply-To: <20021216135453.3823.qmail@escalade.vistahp.com>
Message-ID: <Pine.LNX.3.95.1021216090324.20273A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, Brian Jackson wrote:

> You could always boot once with nosmp and run some benchmarks and then 
> reboot (with smp) and run some more benchmarks, and see if there is a 
> difference. 
> 
>  --Brian Jackson 
> 
> 
> Scott Robert Ladd writes: 
> 
> > Zwane Mwaikambo wrote:
> >> It's ok.
> > 
> > I'm not so sure. 
> > 
> > To get the most benefit from two logical CPUs, don't I need the kernel to
> > operate as a 2-CPU SMP system? 
> > 
> > Windows XP initializes the system as SMP with two CPUs; when I run an OpenMP
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How do you know this? How can I learn what Windows does with
Win/2000/professional? The only way I know I have two CPUs is when the
machine fails to reboot because the file-system has been completely
trashed by the two CPUs banging on it at the same time. The solution has
been to remove one CPU. M$ claims; "Windows will over-power the system
if two CPUs are present...." Direct quote. If you have two logical
CPUs, you can't remove one, therefore, unless M$ has fixed the problem(s)
in XP, you can't use Windows with two logical CPUs, i.e., hyperthreading.


> > application under Windows, it reports two CPUs and a maximum of two threads.
> > Under Linux, 
> >


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


