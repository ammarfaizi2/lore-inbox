Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSAZCmG>; Fri, 25 Jan 2002 21:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAZCl4>; Fri, 25 Jan 2002 21:41:56 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:18306 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S288994AbSAZClq>; Fri, 25 Jan 2002 21:41:46 -0500
Date: Sat, 26 Jan 2002 02:36:58 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>, Robert Love <rml@tech9.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020126023658.A5730@kushida.apsleyroad.org>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <1011650506.850.483.camel@phantasy> <20020121165659.A20501@hq.fsmlabs.com> <E16SqOY-0001mL-00@starship.berlin> <20020124081950.A5668@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020124081950.A5668@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Thu, Jan 24, 2002 at 08:19:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> > > 	It has no demonstrated benefits.
> > 
> > Demonstrated to who?  I have certainly demonstrated the benefits to
> > myself, and others have attested to doing the same.
> 
> I've heard similar arguments in favor of aromatherapy and Scientology.
> 
> What's amazing about all the arguments in favor of preemption is that we
> don't see any published numbers of the obvious application: a periodic
> SCHED_FIFO process. We've done these experiments and the results are
> _dismal_. 

Hi Victor,

I am specifically interested in SCHED_FIFO performance (for a software
modem driver).  Can you publish thes results of yours of SCHED_FIFO
performance with & without the preempt patches?

Thanks,
-- Jamie
