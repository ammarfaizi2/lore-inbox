Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSBEUX2>; Tue, 5 Feb 2002 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBEUXT>; Tue, 5 Feb 2002 15:23:19 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:50440 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S289793AbSBEUXG>;
	Tue, 5 Feb 2002 15:23:06 -0500
Date: Tue, 5 Feb 2002 20:28:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Warning, 2.5.3 eats filesystems
Message-ID: <20020205192826.GA112@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.5.3 managed to damage my ext2 filesystem (few lost directories);
beware.
								Pavel

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 10b9:1647 (Acer Laboratories Inc. [ALi]) (rev 4).
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 3).
      IRQ 9.
      Master Capable.  Latency=16.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xfff70000 [0xfff70fff].
  Bus  0, device   4, function  0:
    CardBus bridge: Texas Instruments PCI1420 (rev 0).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   4, function  1:
    CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
      IRQ 11.
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  0, device   6, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 0).
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 18).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1400 [0x14ff].
  Bus  0, device   8, function  1:
    Communication controller: ESS Technology ESS Modem (rev 18).
      IRQ 5.
      I/O at 0x1800 [0x18ff].
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 195).
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0x1000 [0x100f].
  Bus  0, device  16, function  0:
    Ethernet controller: Accton Technology Corporation EN-1216 Ethernet Adapter (rev 17).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=255.Max Lat=255.
      I/O at 0x1c00 [0x1cff].
      Non-prefetchable 32 bit memory at 0xea001000 [0xea0013ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Trident Microsystems CyberBlade/XP (rev 99).
      IRQ 11.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xee000000 [0xefffffff].
      Non-prefetchable 32 bit memory at 0xea400000 [0xea7fffff].
      Non-prefetchable 32 bit memory at 0xec000000 [0xedffffff].
      Non-prefetchable 32 bit memory at 0xea100000 [0xea107fff].


	
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
