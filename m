Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270476AbRHHNBO>; Wed, 8 Aug 2001 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270477AbRHHNBE>; Wed, 8 Aug 2001 09:01:04 -0400
Received: from [206.166.249.112] ([206.166.249.112]:18194 "EHLO
	srv-exchange2.adtran.com") by vger.kernel.org with ESMTP
	id <S270476AbRHHNAq>; Wed, 8 Aug 2001 09:00:46 -0400
Message-ID: <3B7137B5.71C35982@adtran.com>
Date: Wed, 08 Aug 2001 07:59:33 -0500
From: Ron Flory <ron.flory@adtran.com>
Organization: Adtran
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
In-Reply-To: <Pine.LNX.4.33.0108071916100.23797-100000@sol.compendium-tech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. Kelsey Hudson" wrote:
> 
> On Tue, 7 Aug 2001, Thodoris Pitikaris wrote:
> 
> > As you will see in the attached file (it's a dmesg from the boot)
> > I have an 1Ghz athlon cpu with a VIA KT133 on a gigabyte GA-7ZX
> > motherboard with 100mhz SDRAM.When I compiled the kernel with
> > cputype=Athlon I continiusly experienced this crash.When I compiled with
> > cputype=i686 everything went smooth (OS is Redhat 7.1)
> 
> It's a bug in that screwed up compiler redhat shipped with 7.1. AFAIK, the
> only difference between an athlon-specific kernel and an i686-specific
> kernel are the options in the compiler command line when compiling the
> kernel.

 RH has posted updates to many of the gcc-xxx tools, have you installed
the updated compilers and libraries ?

ron
