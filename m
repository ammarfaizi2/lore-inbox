Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbRHGPLj>; Tue, 7 Aug 2001 11:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRHGPL0>; Tue, 7 Aug 2001 11:11:26 -0400
Received: from [217.89.38.238] ([217.89.38.238]:36853 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S267615AbRHGPKg>;
	Tue, 7 Aug 2001 11:10:36 -0400
Message-ID: <3B7004B2.6351C900@pcsystems.de>
Date: Tue, 07 Aug 2001 17:09:39 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cpu not detected(x86)
Content-Type: multipart/mixed;
 boundary="------------B3EFE2B3B625D6794E69DD53"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B3EFE2B3B625D6794E69DD53
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

I am trying to run 2.4.7 and have heavily problems with my cpu.
The kernel retected another speed at every start! I attached
three times CPUINFO. The cpu in reality is a p3 650 mhz speedstep.
(may switch down to 500 mhz, but 126 _not_).

Who changed something in the 2.4.7 source ?
I am more or less unable to run X with netscape to write this email
with 126 Mhz!

What to do, where to fix ? Please help asap!

Nico



--------------B3EFE2B3B625D6794E69DD53
Content-Type: text/plain; charset=us-ascii;
 name="CPUINFO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CPUINFO"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 161.858
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 330.95


--------------B3EFE2B3B625D6794E69DD53
Content-Type: text/plain; charset=us-ascii;
 name="CPUINFO2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CPUINFO2"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 127.553
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 244.94


--------------B3EFE2B3B625D6794E69DD53
Content-Type: text/plain; charset=us-ascii;
 name="CPUINFO3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CPUINFO3"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 162.371
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 317.84


--------------B3EFE2B3B625D6794E69DD53--

