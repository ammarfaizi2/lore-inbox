Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266400AbRGQNBR>; Tue, 17 Jul 2001 09:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266399AbRGQNBH>; Tue, 17 Jul 2001 09:01:07 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:54026 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S266456AbRGQNAz>; Tue, 17 Jul 2001 09:00:55 -0400
Date: Tue, 17 Jul 2001 09:00:59 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Large memory oops/odd behaviour Linux 2.2, seeking recommendations
In-Reply-To: <Pine.LNX.4.33.0107171343410.8409-100000@tahallah.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0107170849140.6752-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  I am just collecting information on which kernel
	versions have worked best wtih a config liek the below & what
	I s/b watching out for system wise .  Tia ,  JimL

Main memory size: 128 Mbytes < Will be 1024Mbyts >
1 GenuineIntel  processor --+-[ SMP
1 GenuineIntel 2 processor -+
2 16550A serial ports
1 1.44M floppy drive
1 vga+ graphics device
1 keyboard
IDE devices:
  ATAPI 48X CD-ROM drive, 128kB Cache
SCSI devices:
  HITACHI  DK32CJ-36MC <--- Primary drive /
  HITACHI  DK32CJ-36MC <-+
  HITACHI  DK32CJ-36MC <---[ in a Software Raid 5 array .
  HITACHI  DK32CJ-36MC <-+
PCI bus devices:
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 6).
    Host bridge: Unknown vendor CNB30LE PCI Bridge (rev 6).
    VGA compatible controller: ATI Unknown device (rev 39).
    Ethernet controller: Intel 82557 (rev 8).
    ISA bridge: Unknown vendor Unknown device (rev 81).
    IDE interface: Unknown vendor Unknown device (rev 0).
    USB Controller: Unknown vendor Unknown device (rev 4).
    SCSI storage controller: Adaptec AIC-7892 (rev 2).


       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

