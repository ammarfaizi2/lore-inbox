Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313457AbSC2PYp>; Fri, 29 Mar 2002 10:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313460AbSC2PYg>; Fri, 29 Mar 2002 10:24:36 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:6543 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313459AbSC2PYY>; Fri, 29 Mar 2002 10:24:24 -0500
Message-ID: <3CA486FF.5003AA42@wanadoo.fr>
Date: Fri, 29 Mar 2002 16:23:43 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre4-ac[23] do not boot
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

2.4.19-pre4-ac[23] does not boot. I've not tested ac1 but vanilla pre4
works.

It stops there,

Mar 29 16:13:24 f5ibh kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS
settings: hdc:pio, hdd:pio
Mar 29 16:13:24 f5ibh kernel: hda: QUANTUM FIREBALLP LM30, ATA DISK
drive
Mar 29 16:13:24 f5ibh kernel: hdb: ST3491A, ATA DISK drive
Mar 29 16:13:24 f5ibh kernel: hdc: GoldStar CD-RW CED-8083B, ATAPI CDROM
drive
Mar 29 16:13:24 f5ibh kernel: hdd: CREATIVECD3621E, ATAPI CDROM drive
Mar 29 16:13:24 f5ibh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 29 16:13:24 f5ibh kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 29 16:13:24 f5ibh kernel:  ALI15X3: Ultra DMA enabled
Mar 29 16:13:24 f5ibh kernel: hda: QUANTUM FIREBALLP LM30, 28629MB
w/1900kB Cache, CHS=3649/255/63, (U)DMA
Mar 29 16:13:24 f5ibh kernel:  ALI15X3: MultiWord DMA enabled
Mar 29 16:13:24 f5ibh kernel: hdb: ST3491A, 408MB w/120kB Cache,
CHS=899/15/62, DMA
Mar 29 16:13:24 f5ibh kernel: Partition check:
Mar 29 16:13:24 f5ibh kernel:  hda: hda1 hda2 hda3 hda4
Mar 29 16:13:24 f5ibh kernel:  hdb: 



There is only one partition on hdb.
Well, it is an ooold disk and I can survive without it.


----
regards
	Jean-Luc
