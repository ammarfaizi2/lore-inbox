Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSLTSmV>; Fri, 20 Dec 2002 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSLTSmV>; Fri, 20 Dec 2002 13:42:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264945AbSLTSmU>; Fri, 20 Dec 2002 13:42:20 -0500
Date: Fri, 20 Dec 2002 13:48:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: Which Gigabit ethernet card?
In-Reply-To: <1040391936.973.14.camel@paragon.slim>
Message-ID: <Pine.LNX.3.96.1021220134612.1509A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002, Jurgen Kramer wrote:

> I know this is a bit OT but because here are the kernel driver hackers
> this might be the right place to ask.
> 
> I am looking for a couple of PCI Gigabit ethernet adapters to play
> around with SAN/NAS stuff like iSCSI and HyperSCSI and the like. There
> are variuos adapters around which work with Linux. My choice would be
> based on the following:
> 
> - Relatively cheap, around $100/EUR100
> - 32 bit/33MHz PCI compatible
> - Low cpu usage
> - Busmaster DMA
> - Opensource Linux driver
> - zero-copy capable
> - etc.
> 
> What card is best? 3Com, Intel or National Semi based?

01:07.0 Ethernet controller: Alteon Networks Inc. AceNIC Gigabit Ethernet
  (Fibre) (rev 01)

Works for me, and I have a fait amount of other traffic on other NICs.

00:02.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 
  [PCnet LANCE] (rev 44)
00:09.0 Ethernet controller: Intel Corporation 82557
  [Ethernet Pro 100] (rev 08)


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

