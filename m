Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSH1Gn3>; Wed, 28 Aug 2002 02:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSH1GnZ>; Wed, 28 Aug 2002 02:43:25 -0400
Received: from rekin.go2.pl ([212.126.20.3]:50957 "HELO rekin.go2.pl")
	by vger.kernel.org with SMTP id <S318739AbSH1GnY>;
	Wed, 28 Aug 2002 02:43:24 -0400
To: linux-kernel@vger.kernel.org
From: <mucharek@o2.pl>
Date: Wed, 28 Aug 2002 08:47:44
Subject: =?iso-8859-2?Q?Bug=20when=20compiled=20\"under\"=20Athlon?=
Reply-To: mucharek@o2.pl
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
X-Mailer: first3.pl WebMailv2.02. Usluga Poczty Elektronicznej dla o2.pl
X-Priority: 3
X-MSMail-Priority: Normal
X-Originator: 194.29.138.1
Message-Id: <20020828064744.A3AB4BFE8@rekin.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. After compiling the kernel to work with AMD Athlons', some modules 
do not load.
2. After compiling the kernel, to work with "Athlon/Duron" some 
modules lik ppp* usb* do not get modeprobed or insmoded. I get an 
error message about a "unresolved definition: _mmxmem_cpy".
3. kernel, Athlon, compiling, insmod, modprobe, ppp.o, usbcore.o
4. Kernel version: 2.4.19
5. Environment: Slackware 8.0, Athlon 900MHz, 512 MB RAM, GeForce2 
GTS 64MB DDR, AC97 soundcard, mainboard based on VIA chipsets.


