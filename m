Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSAUPpR>; Mon, 21 Jan 2002 10:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSAUPpH>; Mon, 21 Jan 2002 10:45:07 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:6922 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287158AbSAUPo7>;
	Mon, 21 Jan 2002 10:44:59 -0500
Date: Mon, 21 Jan 2002 08:43:44 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121084344.A13455@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C439D02.EBCD78C4@mvista.com> <20020115053901.C32605@hq.fsmlabs.com> <E16SgXE-0001i8-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16SgXE-0001i8-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 21, 2002 at 04:38:59PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 04:38:59PM +0100, Daniel Phillips wrote:
> On January 15, 2002 01:39 pm, yodaiken@fsmlabs.com wrote:
> > My reservation about preemption as an implementation technique is that
> > it has costs, which seem to be not easily boundable, but not very 
> > clear benefits.
> 
> To me the benefit is clear enough: ASAP scheduling of IO threads, a simple 
> heuristic that improves both throughput and latency.

I think of "benefit", perhaps naiively, in terms of something that can
be measured or demonstrated rather than just announced.


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

