Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKTUdm>; Wed, 20 Nov 2002 15:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSKTUdm>; Wed, 20 Nov 2002 15:33:42 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:27785 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261411AbSKTUdm>; Wed, 20 Nov 2002 15:33:42 -0500
Message-Id: <4.3.2.7.2.20021120213759.00b178b0@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 20 Nov 2002 21:40:51 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: 2.4.20-rc2 strange L1 cache values
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another peculiar thing - Why is /proc/cpuinfo showing "ht" ?

processor           : 0
vendor_id           : GenuineIntel
cpu family           : 15
model                 : 2
model name       : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping             : 4
cpu MHz             : 2400.159
cache size          : 512 KB
fdiv_bug             : no
hlt_bug               : no
f00f_bug            : no
coma_bug          : no
fpu                      : yes
fpu_exception   : yes
cpuid level         : 2
wp                      : yes
flags                   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
pge mca cmov pat pse36
                              clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips          : 4784.12

