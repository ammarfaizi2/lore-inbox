Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbSLRUgc>; Wed, 18 Dec 2002 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbSLRUgc>; Wed, 18 Dec 2002 15:36:32 -0500
Received: from mid-1.inet.it ([213.92.5.18]:2192 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id <S267468AbSLRUgb> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 15:36:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: marco mascherpa aka mush <mush@monrif.net>
To: "Steve Lee" <steve@tuxsoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: A7M266-D problems with integrate sound device and USB 2.0 PCI card
Date: Wed, 18 Dec 2002 21:43:55 +0100
User-Agent: KMail/1.4.3
References: <000301c2a6d5$bc9bfee0$0201a8c0@pluto>
In-Reply-To: <000301c2a6d5$bc9bfee0$0201a8c0@pluto>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212182143.55943.mush@monrif.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 December 2002 21:40, Steve Lee wrote:
> One of my systems uses the A7M266-D and I've never had any issues with
> the onboard sound or the usb 2.0 pci card.  I'm wondering if something
> else in your system could be causing the conflict?

i can't imagine what could it be. here's my lspci in case you see something 
unusual:

root@penelope mush # lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 
04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 
07)
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:05.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine] (rev 06)
02:08.0 USB Controller: NEC Corporation USB (rev 41)
02:08.1 USB Controller: NEC Corporation USB (rev 41)
02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

