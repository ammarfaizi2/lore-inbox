Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263634AbSITU74>; Fri, 20 Sep 2002 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263632AbSITU7o>; Fri, 20 Sep 2002 16:59:44 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:40203 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263634AbSITU6m>; Fri, 20 Sep 2002 16:58:42 -0400
Date: Fri, 20 Sep 2002 23:03:15 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.37: different bogomips values for identical cpu's in smp system?
Message-ID: <20020920210315.GB526@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 703.352
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1380.35

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 703.352
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1404.92

Strange - my first CPU has lower bogomips?

Jurriaan
-- 
"A cross-dressing ghost? I think he's got enough problems as it is."
	Simon R Green - Beyond the Blue Moon
GNU/Linux 2.5.37 SMP/ReiserFS 2x1380 bogomips load av: 0.46 0.18 0.06
