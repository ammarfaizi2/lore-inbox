Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUIAL5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUIAL5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUIALyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:54:18 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:19863 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266263AbUIALu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:50:59 -0400
From: Romain Moyne <aero_climb@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Time runs exactly three times too fast
Date: Thu, 2 Sep 2004 14:53:09 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409021453.09730.aero_climb@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm french, sorry for my bad english :(

I have a problem with my kernel: Time runs exactly three times too fast.

I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success. 
It is really strange because yesterday I reinstalled my debian with a kernel 
2.6.8.1 (made by me): Time ran correctly. And this morning when I rebooted my 
computer (Compaq presario R3000 series, R3215EA exactly) the time is running 
again three times too fast (with the kernel 2.6.8.1 and 2.6.9-rc1).

All my applications (KDE, command "date"...) runs three times too fast. It's 
very annoying.

My /dev/cpuinfo : 
presario:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 12
model name      : AMD Athlon(tm) XP Processor 3000+
stepping        : 0
cpu MHz         : 266.127
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmovpat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext 3dnowext 3dnow
bogomips        : 517.12

My config file for my kernel is here: 
http://romain.webzzanine.net/linux/myconfig-2.6.8.1

Please help me :)
Romain Moyne
