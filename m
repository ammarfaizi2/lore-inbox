Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbTC1HWD>; Fri, 28 Mar 2003 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbTC1HWD>; Fri, 28 Mar 2003 02:22:03 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:21510
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262241AbTC1HWB>; Fri, 28 Mar 2003 02:22:01 -0500
Date: Thu, 27 Mar 2003 23:29:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 64GB NUMA-Q before pgcl
In-Reply-To: <Pine.LNX.4.50.0303280045240.2884-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.10.10303272329140.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is too funny, I did not expect a reply to the joke.
Thanks!

Cheers,

On Fri, 28 Mar 2003, Zwane Mwaikambo wrote:

> On Thu, 27 Mar 2003, Andre Hedrick wrote:
> 
> > 
> > Where is the IDE/ATA in the system?
> 
> Not really there...
> 
> piix: 450NX errata present, disabling IDE DMA.
> piix: A BIOS update may resolve this.
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> PIIX4: IDE controller at PCI slot 00:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PCI: Setting latency timer of device 00:0e.1 to 64
>     ide0: BM-DMA at 0x00e0-0x00e7, BIOS settings: hda:pio, hdb:pio
> PIIX4: IDE controller at PCI slot 00:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 03:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 03:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 05:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 05:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 07:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 07:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 09:0e.1
> PCI: Enabling device 09:0e.1 (0000 -> 0001)
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 09:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 0b:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 0b:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 0d:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 0d:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> PIIX4: IDE controller at PCI slot 0f:0e.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> PIIX4: port 0x01f0 already claimed by ide0
> PIIX4: neither IDE port enabled (BIOS)
> PIIX4: IDE controller at PCI slot 0f:10.0
> PIIX4: device not capable of full native PCI mode
> PIIX4: device disabled (BIOS)
> 
> -- 
> function.linuxpower.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

