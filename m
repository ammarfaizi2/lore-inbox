Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbSLGEYV>; Fri, 6 Dec 2002 23:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbSLGEYV>; Fri, 6 Dec 2002 23:24:21 -0500
Received: from web20408.mail.yahoo.com ([66.163.169.96]:34390 "HELO
	web20420.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267716AbSLGEYU>; Fri, 6 Dec 2002 23:24:20 -0500
Message-ID: <20021207043158.45345.qmail@web20420.mail.yahoo.com>
Date: Fri, 6 Dec 2002 20:31:58 -0800 (PST)
From: Z F <mail4me9999@yahoo.com>
Subject: CPU cache problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

Sorry to bother you with such a question, but I have a 
Intel 1.7GHz Celeron processor with ASUS P4S533 motherboard.
The problem I have is that cat /proc/cpuinfo reports that

cache size      : 20 KB

As far as I know, the CPU has 128K L2 cache.

The kernel version installed on my computer is 2.4.18.
I tried using cachesize=128 as a boot parameter, but it did not help.
L2 cache is enabled in BIOS.

Could someone tell me why it is happening, how to fix it and should I
be
worried that the motherboard is defective.

Thank you very much for your kind help

Lazar

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
