Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292975AbSCIXND>; Sat, 9 Mar 2002 18:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292979AbSCIXMy>; Sat, 9 Mar 2002 18:12:54 -0500
Received: from leviathan.kumin.ne.jp ([211.9.65.12]:32323 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S292975AbSCIXMs>; Sat, 9 Mar 2002 18:12:48 -0500
Message-Id: <200203092312.AA00022@prism.kumin.ne.jp>
Date: Sun, 10 Mar 2002 08:12:28 +0900
To: linux-kernel@vger.kernel.org
Cc: nakasei@fa.mdis.co.jp
Subject: 2.2.21-pre4 hung up
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update to linux-2.2.20 + patch-2.2.21-pre4.
before I used linux-2.2.20 + patch-2.2.21-pre3, and worked fine.
linux-2.2.21-pre4 is normal end to patch, compile and install, but bootup failuer.

these messages displayed on console, and hung up.

===== messaged start =====
Uncompressing Linux... Ok, booting the kernel.
Linux version 2.2.21pre4 (root@homesv) (gcc version 2.95.3 20010315 (release)) #
1 Sun Mar 10 07:31:33 JST 2002
USER-provided physical RAM map:
 USER: 000a0000 @ 00000000 (usable)
 USER: 05efd000 @ 00100000 (usable)
Detected 400916 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 95824k/98292k abailable (816k kernel code, 412k reserved, 1180k data, 60k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
CPU: L1 I cache: 16K, L1 D cache: 16K
Intel machine check architecture supported.
===== messages end =====

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
