Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSK1NSG>; Thu, 28 Nov 2002 08:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSK1NSG>; Thu, 28 Nov 2002 08:18:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65292 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265477AbSK1NSF>; Thu, 28 Nov 2002 08:18:05 -0500
Date: Thu, 28 Nov 2002 08:24:12 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: =?ISO-8859-1?Q?RE=C2=A0:?= Clock is suddently ticking too fast !  [Kernel2.4.19-pre10-ac2, Intel]
In-Reply-To: <r1_1038354638.2534.76.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021128081914.9795B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Alan Cox wrote:

> Old IBM PC has PIC (peripheral interrupt controller) - does the 16 IRQ
> lines and attaches them to the CPU
> 
> Modern PC also as APIC (advanced peripheral interrupt controller) which
> is in two parts - locsl apic is on the CPU, and talks over a link to one
> or more io-apics that attach to the devices on the bus

That's interesting, I thought when the first APIC came out it was the one
on the CPU as stood for "Attached Processor Interrupt Controller" to
replace the 8259. Acronym overload? 

> "noapic" says to run the box like an old IBM PC

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

