Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTL1CHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbTL1CHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:07:23 -0500
Received: from [212.28.208.94] ([212.28.208.94]:51723 "HELO dewire.com")
	by vger.kernel.org with SMTP id S264922AbTL1CHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:07:22 -0500
From: Robin Rosenberg <roro.l@dewire.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 pci address space collission
Date: Sun, 28 Dec 2003 02:22:21 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312280222.21712.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's this Address space collission?

--- robin

Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6c10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa093, dseg 0x400
pnp: 00:00: ioport range 0x370-0x371 has been reserved
pnp: 00:0a: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0a: ioport range 0x8000-0x803f has been reserved
pnp: 00:0a: ioport range 0x7000-0x700f has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Address space collision on region 7 of bridge 0000:00:07.3 [8000:803f]
PCI: Address space collision on region 8 of bridge 0000:00:07.3 [7000:701f]
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0

