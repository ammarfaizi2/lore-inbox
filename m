Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSAUVue>; Mon, 21 Jan 2002 16:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSAUVuZ>; Mon, 21 Jan 2002 16:50:25 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:16656 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S288485AbSAUVuK>;
	Mon, 21 Jan 2002 16:50:10 -0500
Date: Mon, 21 Jan 2002 14:49:37 -0700
From: yodaiken@fsmlabs.com
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020121144937.A18422@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <1011647882.8596.466.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1011647882.8596.466.camel@phantasy>; from rml@tech9.net on Mon, Jan 21, 2002 at 04:16:51PM -0500
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 21, 2002 at 04:16:51PM -0500, Robert Love wrote:
> On Mon, 2002-01-21 at 11:06, yodaiken@fsmlabs.com wrote:
> 
> > I have not seen a single well structured benchmark that shows a significant
> > difference. I've seen lots of benchmarks with odd mixes of different patches
> > showing something unknown. How about a simple clear dbench?
> 
> I and many others have been posting benchmarks for months.
> 
> Here:
> 
> (average of 4 runs of `dbench 16')
> 2.5.3-pre1:		25.7608 MB/s
> 2.5.3-pre1-preempt:	32.341 MB/s
> 
> (old, average of 4 runs of `dbench 16')
> 2.5.2-pre11:		24.5364 MB/s
> 2.5.2-pre11-preempt:	27.5192 MB/s
> 

Robert, with all due respect, my tests of dbench show such high
variation that 4 miserable runs prove exactly nothing.
Did these even come on the same filesystem? 



---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

