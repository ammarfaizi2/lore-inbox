Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267213AbRGPGww>; Mon, 16 Jul 2001 02:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbRGPGwm>; Mon, 16 Jul 2001 02:52:42 -0400
Received: from [212.199.49.31] ([212.199.49.31]:10756 "EHLO cupotka.dyn.ee")
	by vger.kernel.org with ESMTP id <S267213AbRGPGw1>;
	Mon, 16 Jul 2001 02:52:27 -0400
Date: Mon, 16 Jul 2001 12:52:03 +0300 (IDT)
From: CuPoTKa <cupotka@cupotka.dyn.ee>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.6 bug - problems with CM8338A soundchip.
Message-ID: <Pine.LNX.4.33.0107161237440.2356-100000@cupotka.dyn.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Part of kernel.log:
kernel: cm: version $Revision: 5.64 $ time 01:44:06 Jul 16 2001
kernel: PCI: Found IRQ 10 for device 00:0f.0
kernel: cm: found CM8338A adapter at io 0xdc00 irq 10

Problem: Sound isn't smooth. It makes strange noise instead music.

I use:
Linux version 2.4.6 (gcc version 2.95.4 20010703 (Debian prerelease)).
Debian testing/unstable linux.
Single PII, 400Mhz CPU.
M748MR PCCHIPS motherboard.

Usefull information: I compiled 2 kernels with CMedia 8338 chip support.
One is kernel 2.4.5 and another 2.4.6. It works with 2.4.5 and dosn't with
2.4.6.

Thanks.

