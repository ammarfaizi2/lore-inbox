Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292390AbSCEWdE>; Tue, 5 Mar 2002 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292318AbSCEWcy>; Tue, 5 Mar 2002 17:32:54 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:43585 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292294AbSCEWco>;
	Tue, 5 Mar 2002 17:32:44 -0500
Date: Tue, 5 Mar 2002 23:31:41 +0100
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic
Message-Id: <20020305233141.3f438954.hanno@gmx.de>
Organization: Mecronome Webdesign - http://www.mecronome.de/
X-Mailer: Sylpheed version 0.7.2claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PC with an Athlon CPU, which has problems with newer kernel-versions. (see lspci-output below)

If I want to boot current Knoppix or Mandrake 8.2beta3 install cds (both based on kernel 2.4.17), it says:

Kernel panic: VFS: Unable to mount root fs on 03:05

It worked fine with the older mandrake 8.1 with kernel 2.4.8.

Any ideas? How can I help to fix this?

Here is lspci output:
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 82)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI Audio Accelerator (rev 02)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS630 GUI Accelerator+3D (rev 31)
