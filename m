Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbTEWJNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTEWJNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:13:46 -0400
Received: from aktion1.adns.de ([62.116.145.13]:36261 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S263970AbTEWJNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:13:44 -0400
Message-ID: <3ECDE94C.3030502@web.de>
Date: Fri, 23 May 2003 11:26:36 +0200
From: Sven Krohlas <darkshadow@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4b) Gecko/20030516
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: Oliver Pitzeier <o.pitzeier@uptime.at>
CC: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
References: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at>
In-Reply-To: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> OK. So now I have to say: _Don't_ use 2.4.20-rc* if you have a aic7xxx. You can
> use 2.4.19 and maybe 2.4.20(?).

Just to clearify: _I don't_ have a aic7xxx!

-------------------
linux:/home/sven # hwinfo --short
cpu:
                       AMD-K6(tm)-III Processor, 500 MHz
keyboard:
                       PS/2 Keyboard
mouse:
  /dev/input/mice      Logitech iFeel Mouse
printer:
  /dev/lp0             Hewlett-Packard HP LaserJet 5L
monitor:
                       PHILIPS 109S
graphics card:
                       Diamond Viper V550
framebuffer:
                       NVidia Riva TNT
sound:
                       Creative Sound Blaster AWE 64
storage:
                       Floppy disk controller
                       LSI Logic / Symbios Logic 53c875
                       Promise 20269
                       Acer Laboratories Inc. [ALi] M5229 IDE
                       IDE interface
network:
                       Realtek RT8139
                       Realtek RTL-8029(AS)
network interface:
  lo                   Loopback network interface
  eth0                 Ethernet network interface
  eth1                 Ethernet network interface
  ppp0                 Network Interface
  sit0                 Network Interface
disk:
  /dev/hda             IC35L120AVV207-0
  /dev/hdc             IC35L120AVV207-0
  /dev/hde             Maxtor 4G120J6
  /dev/hdf             IBM-DJNA-352030
  /dev/hdg             IC35L120AVV207-0
  /dev/hdb             IC35L120AVV207-0
cdrom:
  /dev/sr0             IDE-CD R/RW 8x4x32
  /dev/hdh             R/RW 8x4x32
floppy:
  /dev/fd0             Floppy Disk
usb controller:
                       Acer Laboratories Inc. [ALi] USB 1.1 Controller
bios:
                       BIOS
bridge:
                       Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
                       Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller
                       Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
                       Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
hub:
                       USB OHCI Root Hub
                       USB OHCI Root Hub
                       Hub
                       USB OHCI Root Hub
                       USB OHCI Root Hub
                       USB OHCI Root Hub
                       USB OHCI Root Hub
memory:
                       Main Memory
unknown:
                       FPU
                       DMA controller
                       PIC
                       Timer
                       RTC
                       Keyboard controller
  /dev/lp0             Parallel controller
                       PS/2 Controller
                       ISA PnP Interface
                       Creative Sound Blaster AWE 64
                       Creative Sound Blaster AWE 64
  /dev/ttyS0           16550A
  /dev/ttyS1           16550A
-------------------

Sunday evening I'll try rc3, I'm looking forward to a freezing
system again :-(

Have a nice day.
-- 
BOFH excuse of the day:
The salesman drove over the CPU board.

