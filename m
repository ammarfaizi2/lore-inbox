Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUCBRsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 12:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUCBRsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 12:48:02 -0500
Received: from 215.Red-80-25-136.pooles.rima-tde.net ([80.25.136.215]:63362
	"EHLO ns.leals.com") by vger.kernel.org with ESMTP id S261718AbUCBRr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 12:47:56 -0500
From: Davi Leal <davi@leals.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal, correctable incident
Date: Tue, 2 Mar 2004 19:00:16 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403021900.16085.davi@leals.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about this message?. Note that the system works. I have not had to 
reboot. What meens the below message?.

Do not hesitate ask for more information.

Regards,
Davi Leal



Message from syslogd@AMD at Tue Mar  2 11:27:00 2004 ...
AMD kernel: MCE: The hardware reports a non fatal, correctable incident 
occurred on CPU 0.

Message from syslogd@AMD at Tue Mar  2 11:27:00 2004 ...
AMD kernel: Bank 1: 9400400000000152



$ cat /proc/version 
Linux version 2.6.2 (root@AMD) (gcc version 3.3.3 20040125 (prerelease) 
(Debian)) #1 Wed Feb 4 19:26:25 CET 2004

$ cat /proc/version 
Linux version 2.6.2 (root@AMD) (gcc version 3.3.3 20040125 (prerelease) 
(Debian)) #1 Wed Feb 4 19:26:25 CET 2004
davi@AMD:/Compartida$ 
davi@AMD:/Compartida$ 
davi@AMD:/Compartida$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2400+
stepping        : 0
cpu MHz         : 2010.002
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
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3956.73
$

