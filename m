Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRG1AE2>; Fri, 27 Jul 2001 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbRG1AES>; Fri, 27 Jul 2001 20:04:18 -0400
Received: from web13901.mail.yahoo.com ([216.136.175.27]:9231 "HELO
	web13901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265475AbRG1AEK>; Fri, 27 Jul 2001 20:04:10 -0400
Message-ID: <20010728000417.33999.qmail@web13901.mail.yahoo.com>
Date: Fri, 27 Jul 2001 17:04:17 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: serial console startup problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,all,

When linux 2.4.3 startup, our serial console can not
work. I use another serial port to print some debug
messages, it likes following:

hda: 16841664 sectorsp: (8623 MB)p: w/512KiB Cachep:,
CHS=16708/16/63p:
Partition check:
hda:[PTBL] [1048/255/63] hda1 hda4
Serial driver version 5.05 (2000-12-13) with
MANY_PORTS SHARE_IRQ SERIAL_PCI e
nabled
ttyS00 at 0xb8000000 (irq = 2) is a 16550A
ttyS01 at 0xb8100000 (irq = 3) is a 16550A
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 1020kb freed
Freeing unused kernel memory: 52k freed

kernel BUG at page_alloc.c:191!
kernel BUG at page_alloc.c:191!
kernel BUG at page_alloc.c:191!

Do someone know what's problem it is?
If you know, please help me.

Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
