Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312145AbSCRFqu>; Mon, 18 Mar 2002 00:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312150AbSCRFql>; Mon, 18 Mar 2002 00:46:41 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:1246 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312145AbSCRFq2>; Mon, 18 Mar 2002 00:46:28 -0500
Date: Sun, 17 Mar 2002 22:46:25 -0700
Message-Id: <200203180546.g2I5kP412586@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: Another entry for the MCE-hang list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I just booted 2.4.19-pre3, and it hung right after the MCE
message. This is an Asus P2B-D with two Intel 450 MHz PIII's. Output
of /proc/cpuinfo appended.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 451.032
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 897.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 451.032
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 901.12

