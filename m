Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUIOIaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUIOIaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUIOIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:30:08 -0400
Received: from mail.bbaw.de ([194.95.188.1]:24523 "EHLO hippo.bbaw.de")
	by vger.kernel.org with ESMTP id S263795AbUIOIaD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:30:03 -0400
Date: Wed, 15 Sep 2004 10:29:13 +0200
From: Lars =?ISO-8859-15?Q?T=E4uber?= <taeuber@bbaw.de>
To: linux-kernel@vger.kernel.org
Subject: cdrom recognition on kernel 2.6.8.1 - addition
Message-Id: <20040915102913.70da61af.taeuber@bbaw.de>
Reply-To: Lars =?ISO-8859-15?Q?T=E4uber?= 
	  <taeuber@informatik.hu-berlin.de>
Organization: Berlin-Brandenburgische Akademie der Wissenschaften
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.27.0.10; VDF: 6.27.0.61; host: bbaw.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everybody,

the log with cdrom recognised

............
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdc: DV-516D 0106, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.02 loaded.
sata_sil version 0.54
............



best regards
Lars Täuber
