Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbTCQRgZ>; Mon, 17 Mar 2003 12:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbTCQRfe>; Mon, 17 Mar 2003 12:35:34 -0500
Received: from [213.196.47.88] ([213.196.47.88]:23570 "HELO slash.drecomm.nl")
	by vger.kernel.org with SMTP id <S261814AbTCQRes>;
	Mon, 17 Mar 2003 12:34:48 -0500
Message-ID: <1047923169.3e7609e17dcab@slash.drecomm.nl>
Date: Mon, 17 Mar 2003 18:46:09 +0100
From: Michiel Klaver <michiel@drecomm.nl>
To: linux-kernel@vger.kernel.org
Subject: Tyan tiger 2466 mpx dual processor problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 62.163.71.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Tyan Tiger MPX 2466 mobo has two AMD Athlon MP 2400+ CPU's, but when running 
a standard RedHat or Debian Kernel (i686-smp) it will only recognize one CPU.

When I build my own kernel (2.4.20) with athlon support (k7-smp) it will crash 
at boot time.

My problem is that I can only log-in remotely, and a console monitor is not 
(yet) available, so I have no clue about error messages... :(
Lucky me to use the lilo -R option, so it will return to the default kernel 
after an APC reboot.

What could cause this behaviour?

What should be the BIOS settings for MPS (1.1/1.4)? APIC (on/off)?

Thanks in advance,

Michiel Klaver
The Netherlands.

