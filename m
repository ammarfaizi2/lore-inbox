Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTFBQnC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTFBQnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:43:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22925 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264505AbTFBQm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:42:59 -0400
Date: Mon, 2 Jun 2003 12:58:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: Hyper-threading
In-Reply-To: <Pine.LNX.4.33.0306021147460.31561-100000@router.windsormachine.com>
Message-ID: <Pine.LNX.4.53.0306021249430.16702@chaos>
References: <Pine.LNX.4.33.0306021147460.31561-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Mike Dresser wrote:

> On Mon, 2 Jun 2003, Richard B. Johnson wrote:
>
> > Well it is supposed to. It's a pentium 4 Xeon. If it doesn't
> > support it, ether the CPU or the motherboard are broken.
> > I'll bet on the motherboard.
> > Look further up the dmesg output and you'll see XEON(tm) and
> > 2 CPUs total.
>
> Indeed, I saw that.  On the P4 2.66ghz that you have, the "second" cpu is
> disabled by intel, as they sell hyperthreading only on the newer Xeon P4
> (which you don't have), and the new 800FSB (4x200) units, which again
> you don't have.
>

Well, the CPU I bought was supposed to support hyper-threading. That's
what it even says on the box (new Hyper-thread technology)! I guess
Hyper-thread technology isn't "hyper-thread", only its "technology",
like it's got some pins and takes power.

> ..... CPU clock speed is 2672.7802 MHz.
> ..... host bus clock speed is 133.6388 MHz.
>
> There is a Xeon 2.66 part, however it has 603 pins, and would not fit on
> your IC7-G board, which is a P4 board, not a P4 Xeon board,
>

These were purchased together to be a "hyper-thread" board
for my new system. I have always had two CPUs since SMP became
available, and I wanted to experiment with the new "single-CPU"
SMP architecture.

> CPU0: Intel(R) Pentium(R) 4 CPU 2.66GHz stepping 07 is correct.
>
> OT:  Are your two 100mbit cards PCI or something?  I noticed the onboard
> gigabit adapter isn't detected.
>
> Mike
>

I got ripped off. I got sold a board that doesn't have the gigibit
adapter populated plus, you can't tell from a distance because the
connector is present, but has some metal tape covering the hole.

This board costs $275 plus the CPU was $635. I got badly raped
and the vendor won't take them back.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

