Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSA0Vjn>; Sun, 27 Jan 2002 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSA0Vjf>; Sun, 27 Jan 2002 16:39:35 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:10757 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288733AbSA0Vj1>; Sun, 27 Jan 2002 16:39:27 -0500
Subject: Kernel 2.4.x hangs on ASUS motherboard
From: Mohammed Sameer <Uniball13@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1012167558.4121.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 27 Jan 2002 23:39:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all 
i have a problem with all 2.4 kernels 
i tried rh 7.1 , 7.2 setup & compiled the kernel but it always hangs
after detecting the hard disk controllers giving me a blinking cursor
and i have to press reset to reboot the PC 
tried to boot with the cdrom with hda=noprobe and it worked fine but no
block drive to install on, tried to boot with a floppy passing
hdd=noprobe but it hanged 
hda --> my hard drive 
hdd --> cdrom 
i think it's a problem with the hard drive configuration? 
my motherboard is ASUS SP97-XV 

thanks for any help 

here is the kernel messages 

ttyS00 at 0x03f8 (irq = 4) is a 16550A 
ttyS01 at 0x02f8 (irq = 3) is a 16550A 
pty: 256 Unix98 ptys configured 
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13) 
Real Time Clock Driver v1.09 
RAM disk driver initialized:  16 RAM disks of 4096K size 
SIS5513: IDE controller on PCI bus 00 dev 09 
SIS5513: not 100% native mode: will probe irqs later 
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA 
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:DMA 
hda: WDC WD200EB-00CSF0, ATA DISK drive 
hdb: WDC AC34300L, ATA DISK drive 
hdd: ASUS CD-S520/A, ATAPI CDROM drive 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
ide1 at 0x170-0x177,0x376 on irq 15 

=========== HANG HERE ============== 
hda: WDC WD200EB-00CSF0, 19092MB w/2048kB Cache, CHS=2434/255/63 
hdb: WDC AC34300L, 4104MB w/256kB Cache, CHS=523/255/63 



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

