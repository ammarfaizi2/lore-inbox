Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRCQCNB>; Fri, 16 Mar 2001 21:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRCQCMl>; Fri, 16 Mar 2001 21:12:41 -0500
Received: from [142.176.139.106] ([142.176.139.106]:63494 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S131480AbRCQCM3>;
	Fri, 16 Mar 2001 21:12:29 -0500
Date: Fri, 16 Mar 2001 22:10:55 -0400 (AST)
From: Ted Gervais <ve1drg@ve1drg.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2-ac20 
In-Reply-To: <15935.984794256@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0103162210210.6062-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Keith Owens wrote:

Thanks Keith for your note. I will check out your 'points' and see what
happens. Anything is possible..



> Date: Sat, 17 Mar 2001 12:57:36 +1100
> From: Keith Owens <kaos@ocs.com.au>
> To: Ted Gervais <ve1drg@ve1drg.com>
> Subject: Re: Kernel 2.4.2-ac20 
> 
> On Fri, 16 Mar 2001 11:40:42 -0400 (AST), 
> Ted Gervais <ve1drg@ve1drg.com> wrote:
> >unix:/etc# insmod soundmodem
> >Using /lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o
> >/lib/modules/2.4.2-ac20/kernel/drivers/net/hamradio/soundmodem/soundmodem.o: unresolved symbol hdlcdrv_transmitter_Rccccc7c3
> 
> Either you forgot to load hdlcdrv.o first (modprobe soundmodem would be
> better than insmod soundmodem) or you have been bitten by the broken
> Makefiles (see http://www.tux.org/lkml/#s8-8).
> 

---
Earth is a beta site. 
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


