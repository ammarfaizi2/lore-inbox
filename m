Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSAUQHh>; Mon, 21 Jan 2002 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSAUQHR>; Mon, 21 Jan 2002 11:07:17 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:12554 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287254AbSAUQHG>;
	Mon, 21 Jan 2002 11:07:06 -0500
Date: Mon, 21 Jan 2002 09:06:02 -0700
From: yodaiken@fsmlabs.com
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121090602.A13715@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E16SgwP-0001iN-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Jan 21, 2002 at 05:05:01PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > I think of "benefit", perhaps naiively, in terms of something that can
> > be measured or demonstrated rather than just announced.
> 
> But you see why asap scheduling improves latency/throughput *in theory*, 

Nope. And I don't even see a relationship between preemption and asap I/O
schedulding. What make you think that I/O threads won't be preempted by
other threads?

> don't you?  As for the measured benefit, there have been a steady stream of 
> postive reports on lkml. 

I have not seen a single well structured benchmark that shows a significant
difference. I've seen lots of benchmarks with odd mixes of different patches
showing something unknown. How about a simple clear dbench?

>My own experience is that the usability of my 
> laptop with its small memory is much improved under heavy IO load.

No comment.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

