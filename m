Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRI1Bse>; Thu, 27 Sep 2001 21:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275780AbRI1BsY>; Thu, 27 Sep 2001 21:48:24 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:25092 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S275778AbRI1BsS>;
	Thu, 27 Sep 2001 21:48:18 -0400
Date: Thu, 27 Sep 2001 18:32:49 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: ASL Presents UltraDMA 133 and 160GB drive support in Linux!
Message-ID: <Pine.LNX.4.31.0109271829470.23925-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PDC20269: IDE controller on PCI bus 02 dev 20
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 4G160H8, ATA DISK drive
ide2 at 0xa000-0xa007,0xa402 on irq 11
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=317632/255/63, UDMA(133)

Linux wins again in the support world.

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

