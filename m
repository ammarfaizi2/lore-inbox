Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131726AbRCXR0K>; Sat, 24 Mar 2001 12:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRCXR0B>; Sat, 24 Mar 2001 12:26:01 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:29715 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131726AbRCXRZx>; Sat, 24 Mar 2001 12:25:53 -0500
Date: Sat, 24 Mar 2001 18:25:16 +0100
From: Alex Riesen <vmagic@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Message-ID: <20010324182516.A1255@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, dear all

As i recompiled 2.4.2-ac20 with ACPI support
the system cannot switch itself off.
With APM it work without any problem.

I get a message "Couldn't switch to S5" if
try to call reboot(2).
At load it shows that the mode is supported.

Alex Riesen

P.S.
Motheboard Asus CUV4X

/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.605
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19


