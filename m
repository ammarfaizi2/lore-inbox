Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273130AbRIJB0V>; Sun, 9 Sep 2001 21:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273128AbRIJB0L>; Sun, 9 Sep 2001 21:26:11 -0400
Received: from mail.tconl.com ([204.26.80.9]:30731 "EHLO hermes.tconl.com")
	by vger.kernel.org with ESMTP id <S273129AbRIJBZ6>;
	Sun, 9 Sep 2001 21:25:58 -0400
Message-ID: <3B9C16AF.8F1599E6@tconl.com>
Date: Sun, 09 Sep 2001 20:26:08 -0500
From: Joe Fago <cfago@tconl.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.9: PDC20267 not working
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

System hangs on boot:


Uniform Multi-Platform E_IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20267: IDE controller on PCI bus 00 dev 40
PCI: Assigned IRQ 10 for device 00:08.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode
  ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda: pio, hdb: pio
  ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc: pio, hdd: DMA
hda: Maxtor 2B020H1, ATA DISK drive


This is the only device attached to the controller. Any suggestions?

Thanks,
Joe

