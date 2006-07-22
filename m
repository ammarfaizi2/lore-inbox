Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWGVQGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWGVQGa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWGVQG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:06:29 -0400
Received: from inter.mezzo.net ([217.110.105.10]:18084 "EHLO inter.mezzo.net")
	by vger.kernel.org with ESMTP id S1750826AbWGVQG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:06:29 -0400
Date: Sat, 22 Jul 2006 18:06:20 +0200 (CEST)
From: Peter Koellner <peter@asgalon.net>
X-X-Sender: peter@noisydwarf
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: usb storage device not working anymore in 2.6.17.5 and
 2.6.17.6 (continued)
Message-ID: <Pine.LNX.4.62.0607221803470.6065@noisydwarf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software from scripts/ver_linux:

Linux noisydwarf 2.6.17.6 #1 PREEMPT Sat Jul 22 14:36:58 CEST 2006
i686 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
jfsutils               1.1.8
pcmcia-cs              3.2.8
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.96
udev                   093
Modules Loaded         ndiswrapper radeon binfmt_misc cpufreq_ondemand
rfcomm l2cap ipv6 autofs4 xfrm_user xfrm4_tunnel tunnel4 ipcomp esp4
ah4 deflate zlib_deflate twofish serpent aes blowfish des sha256 sha1
md5 crypto_null dm_mod msr cpuid fat ntfs cyberjack hci_usb bluetooth
usbserial usbhid eth1394 8250_pci 8250 serial_core snd_intel8x0
ehci_hcd uhci_hcd snd_intel8x0m snd_ac97_codec snd_ac97_bus joydev
evdev snd_pcm snd_timer snd snd_page_alloc ohci1394 ieee1394

-- 
peter koellner <peter@asgalon.net>
