Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTAFSVU>; Mon, 6 Jan 2003 13:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTAFSVU>; Mon, 6 Jan 2003 13:21:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4371 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266627AbTAFSVT>; Mon, 6 Jan 2003 13:21:19 -0500
Date: Mon, 6 Jan 2003 13:27:41 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Blueman <daniel.blueman@gmx.net>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Gigabit/SMP performance problem
In-Reply-To: <b8ce5e32.0301040439.7bdaa903@posting.google.com>
Message-ID: <Pine.LNX.3.96.1030106132528.10550A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2003, Daniel Blueman wrote:

> It's interesting you have IRQs balanced over the two logical
> processors. I can't get this on HT Xeons with stock RedHat 7.3 kernel.

I think he's using two physical processors, if by "logical processors" you
are thinking HT... I also recall he has HT off, but the original post
isn't handy.

> 
> Can you post the exact kernel version string, please?
> 
> TIA,
>   Dan
> 
> "Avery Fay" <avery_fay@symantec.com> wrote in message news:<OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>...
> > Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load balancing as 
> > shown below (seems to be applied to Red Hat's kernel). Here's 
> > /proc/interrupts:

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

