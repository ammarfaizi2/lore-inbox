Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313271AbSC1WrM>; Thu, 28 Mar 2002 17:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313273AbSC1WrD>; Thu, 28 Mar 2002 17:47:03 -0500
Received: from whisper.jaggnet.org ([208.250.80.29]:5896 "EHLO
	whisper.jaggnet.org") by vger.kernel.org with ESMTP
	id <S313272AbSC1Wqv>; Thu, 28 Mar 2002 17:46:51 -0500
Date: Thu, 28 Mar 2002 14:46:47 -0800 (PST)
From: Bill Hammock <xcp@whisper.jaggnet.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Screen corruption in 2.4.18
Message-ID: <Pine.LNX.4.33.0203281443500.17304-100000@whisper.jaggnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Does everyone who sees this problem have the 8363/5 combination with the
>onboard Pro-Savage
>
>
>Alan


I have this chipset with a built-in S3 Savage and am experiencing the
problem.  Up till now I just removed the line from pci-pc.c, safe or
unsafe it fixed the video garble.

I have the Asus Terminator "bare bones" system.  The small cute all-in-one
box.


00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 81)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: S3 Inc. ProSavage KM133 (rev 03)


Please CC,
BH

