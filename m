Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289069AbSAIWrb>; Wed, 9 Jan 2002 17:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAIWrW>; Wed, 9 Jan 2002 17:47:22 -0500
Received: from proxy.ATComputing.nl ([195.108.229.1]:11255 "EHLO
	atcmpg.ATComputing.nl") by vger.kernel.org with ESMTP
	id <S289066AbSAIWrK>; Wed, 9 Jan 2002 17:47:10 -0500
Date: Wed, 9 Jan 2002 23:47:06 +0100
From: Daniel Tuijnman <daniel@ATComputing.nl>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problems in 2.4.16
Message-ID: <20020109234706.B4555@ATComputing.nl>
In-Reply-To: <20020109143434.A20955@ATComputing.nl> <Pine.LNX.4.33.0201090640080.13260-100000@shell1.aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201090640080.13260-100000@shell1.aracnet.com>; from znmeb@aracnet.com on Wed, Jan 09, 2002 at 06:47:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I installed a 2.4.16 kernel on a 486DX2-50 machine with 8MB memory and
> > 24MB swap and got insurmountable problems.
> 
> [snip]
> 
> > It seems to me that something definitely is wrong with the kernel's
> > memory management.
> 
> Well ... maybe *in theory* 2.4.16 should work on a machine with that
> little RAM but I'd say in practice Linux has simply outgrown your
> machine. Have you tried any other 2.4 kernels, say, before 2.4.10 when
> the VM changed?

No I haven't. Was the older VM better, then? Sorry to put it so blunt,
but if it can't swap out unneeded data, it is broken.
I've seen here people report having 1GB of memory and still running out
of it...

> Have you considered going to a garage sale and spending
> the local equivalent of $25 or $30 US for a more powerful computer?

1. I'm setting up this machine to act as a firewall for my cable
connection, so why do I need a more powerful computer?

2. My first Linux experience was on a P60 with 8MB of memory, 16MB swap.
I ran X and used TeX on my 300p. Ph.D. thesis, and that ran fine.
So why should I need more to get less?

I happen to have this machine, it works and is suited for the job.
Now please let's not get a bloatware, consumerism-throw away attitude.

Before this starts a flameware, let me make one thing clear: my main
point is, there is something wrong when an application, for which there
is plenty of (virtual) memory, grinds the whole machine to a standstill.

Greetings,
Daniel Tuijnman

