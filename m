Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSLPSgg>; Mon, 16 Dec 2002 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLPSgg>; Mon, 16 Dec 2002 13:36:36 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62155 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266987AbSLPSgf> convert rfc822-to-8bit; Mon, 16 Dec 2002 13:36:35 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Where is this printk?
Date: Mon, 16 Dec 2002 19:43:24 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212161938.28306.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

does anyone know where this is printed out in kernel source?

Linux version 2.4.20 (root@codeman) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #1 Mon Dec 16 16:54:44 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
...

I only want to know where the first line is printed out (that is a dmesg 
output). I want to put in a printk just before the first line.

I thought somewhere in arch/$arch/kernel/setup.c but I cannot figure out 
where.

ciao, Marc
