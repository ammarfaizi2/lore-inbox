Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTEEQ2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbTEEQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:27:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44481 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263648AbTEEQYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:24:49 -0400
Date: Mon, 05 May 2003 09:36:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 652] New: procfs: duplicated capacity entries in
 /proc/ide/hd*/ 
Message-ID: <10510000.1052152606@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=652

           Summary: procfs: duplicated capacity entries in /proc/ide/hd*/
    Kernel Version: 2.5.68-bk+
            Status: NEW
          Severity: low
             Owner: bugme-janitors@lists.osdl.org
         Submitter: alexander.riesen@synopsys.com
                CC: alan@lxorguk.ukuu.org.uk


Distribution: debian-unstable

Hardware Environment: compaq armada 1592 DT

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
OPTI621X: IDE controller at PCI slot 00:14.0
OPTI621X: chipset revision 48
OPTI621X: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
hda: IBM-DTCA-23240, ATA DISK drive
hdb: UJDA120, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
hda: 6354432 sectors (3253 MB) w/468KiB Cache, CHS=6304/16/63, (U)DMA
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >


