Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281242AbRKEREc>; Mon, 5 Nov 2001 12:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281243AbRKEREP>; Mon, 5 Nov 2001 12:04:15 -0500
Received: from slide.SoftHome.net ([66.54.152.30]:2192 "HELO
	waltz.SoftHome.net") by vger.kernel.org with SMTP
	id <S281242AbRKERED>; Mon, 5 Nov 2001 12:04:03 -0500
Message-ID: <20011105162810.13878.qmail@softhome.net>
From: krajput@softhome.net
To: linux-kernel@vger.kernel.org
Subject: Unresolved Symb...in 2.4.12 ehci installation
Date: Mon, 05 Nov 2001 16:28:10 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have upgraded my Linux 7.1 (kernel version 2.4.2) to kernel version
2.4.12. I want to install the linux ehci driver as well. On applying the
required changes in the usr/src/linux/drivers/usb/Makefile and
usr/src/linux/drivers/usb/Config.in files and selecting the EHCI as a
module in make menuconfig. When i get to the part where i do make
modules_install after make modules, i get the following error:-

depmode: *** Unresolved Symbols in
/lib/modules/2.4.12/kernel/drivers/usb/usbcore.o
depmode: usb_hub_cleanup
depmode: usb_hub_init

I have tried to install the same with and without the kernel version info
but to no avail. Shall be grateful if anybody could advise! Thanking you in
advance.

Kashif!
