Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTJ0WAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTJ0WAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:00:08 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:24961
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263599AbTJ0WAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:00:04 -0500
Date: Mon, 27 Oct 2003 16:59:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Hakona Spect <ear22@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 4Gb memory?
In-Reply-To: <BAY7-F23ko57PJ66ZMA0000af93@hotmail.com>
Message-ID: <Pine.LNX.4.53.0310271658300.21953@montezuma.fsmlabs.com>
References: <BAY7-F23ko57PJ66ZMA0000af93@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Hakona Spect wrote:

> $/sbin/lspci
> 00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge 
> (MCH) (rev 04)
> 00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 
> 04)
> 00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev 
> 04)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 04)
> 00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
> 00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
> 00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
> 00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
> 00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
> (rev 04)
> 01:00.0 VGA compatible controller: nVidia Corporation NV25GL [Quadro4 700 
> XGL] (rev a3)
> 02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
> 03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt 
> Controller (rev 01)
> 04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
> 78)
> 04:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 
> Controller (Link)

I would most probably guess this is the case with your system.
