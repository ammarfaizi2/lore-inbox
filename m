Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTC1Fi2>; Fri, 28 Mar 2003 00:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbTC1Fi2>; Fri, 28 Mar 2003 00:38:28 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:44286
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262212AbTC1Fi0>; Fri, 28 Mar 2003 00:38:26 -0500
Date: Fri, 28 Mar 2003 00:45:41 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andre Hedrick <andre@linux-ide.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: 64GB NUMA-Q before pgcl
In-Reply-To: <Pine.LNX.4.10.10303272136540.25072-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.50.0303280045240.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.10.10303272136540.25072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Andre Hedrick wrote:

> 
> Where is the IDE/ATA in the system?

Not really there...

piix: 450NX errata present, disabling IDE DMA.
piix: A BIOS update may resolve this.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
PIIX4: IDE controller at PCI slot 00:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PCI: Setting latency timer of device 00:0e.1 to 64
    ide0: BM-DMA at 0x00e0-0x00e7, BIOS settings: hda:pio, hdb:pio
PIIX4: IDE controller at PCI slot 00:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 03:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 03:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 05:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 05:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 07:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 07:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 09:0e.1
PCI: Enabling device 09:0e.1 (0000 -> 0001)
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 09:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 0b:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 0b:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 0d:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 0d:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)
PIIX4: IDE controller at PCI slot 0f:0e.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
PIIX4: port 0x01f0 already claimed by ide0
PIIX4: neither IDE port enabled (BIOS)
PIIX4: IDE controller at PCI slot 0f:10.0
PIIX4: device not capable of full native PCI mode
PIIX4: device disabled (BIOS)

-- 
function.linuxpower.ca
