Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315672AbSECTaA>; Fri, 3 May 2002 15:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315673AbSECTaA>; Fri, 3 May 2002 15:30:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30592 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315672AbSECT37>; Fri, 3 May 2002 15:29:59 -0400
Date: Fri, 3 May 2002 15:30:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was Discontigmem virt_to_page() ) 
In-Reply-To: <200205032022.PAA04244@ccure.karaya.com>
Message-ID: <Pine.LNX.3.95.1020503152328.8539A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Jeff Dike wrote:

> root@chaos.analogic.com said:
> > Would you please tell me what Unix has 32-bit address space which is
> > not shared with the kernel? 
> 
> I'm planning on doing that with UML at some point.
> 
> The claim that it's not Unix if it doesn't share the process address space
> is just stupid.
> 

No. It's not stupid. Unix defines a kind of operating system that
has certain characteristics and/or attributes. Process/kernel shared
address space is one of them. It's a name that has historical
signifigance.

Linux does not have to be Unix. In fact, divorcing virtual address
space may make a better Operating System and it's good that somebody
it planning that. But the result will not be the 25-30 year old
architecture we call Unix. It will be Linux. And it just might
be the thing that makes Linux shine above others, so don't call
this difference stupid.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

