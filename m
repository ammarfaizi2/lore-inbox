Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbRGUPkJ>; Sat, 21 Jul 2001 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbRGUPkA>; Sat, 21 Jul 2001 11:40:00 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:61649 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267678AbRGUPjt>;
	Sat, 21 Jul 2001 11:39:49 -0400
Date: Sat, 21 Jul 2001 17:39:31 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
cc: Martin Mares <pci-ids@ucw.cz>
Subject: New PCI device
Message-ID: <Pine.LNX.4.33.0107211732080.28026-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

I've got a new toy in my computer :

02:09.0 Network controller: Unknown device 1638:1100 (rev 02)
        Subsystem: Unknown device 1638:1100
        Flags: medium devsel, IRQ 9
        I/O ports at d800 [disabled] [size=128]
        Memory at d5800000 (32-bit, non-prefetchable) [disabled] [size=4K]
        I/O ports at d400 [disabled] [size=64]

Device itself says :

WL11000P
It's a PCMCIA bridge, with one big IC : Manufacturer : PLX , type PCI9052

No idea why the PCI type ID says it's a network controller, it certainly
isn't. The whole package is sold as a Dynalink wireless LAN L11H, a PCI
PCICIA controller with one slot and a PCMCIA card based on a PrismII
chipset.

I'm gonna plug the PCMCIA card in my notebook, see what it doesn. It it
does work, the problem is the PCMCIA card bot been supported. Else I'v got
a big problem :)


	Igmar





-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

