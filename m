Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbSI3NNz>; Mon, 30 Sep 2002 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262057AbSI3NNy>; Mon, 30 Sep 2002 09:13:54 -0400
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:15006 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S262054AbSI3NNx>;
	Mon, 30 Sep 2002 09:13:53 -0400
Subject: 2.5.39 XConfig Processor Detection
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
	 <1033389340.16337.14.camel@irongate.swansea.linux.org.uk> 
	<20020930.052555.123500588.davem@redhat.com> 
	<1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Sep 2002 09:20:21 -0400
Message-Id: <1033392021.1491.6.camel@beowulf.internetstore.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 30 Sep 2002 13:19:19.0159 (UTC) FILETIME=[FBA36870:01C26883]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this has already been noted or if I'm posting
this to the wrong place/annoying you very busy people needlessly,
but when I run XConfig, in the "Processor Type and Features" tab
it autodetects my processor as a Pentium-4 when in fact it is a
P3 700MHZ. The last time I installed a kernel (2.4.x) by hand, it did
autodetect the processor on that machine (Athlon), so I assume that
feature is still active. Anyways, here's the output from my cpuinfo:


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 701.606
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips	: 1399.19


Thanks,

Adam Voigt
adam.voigt@cryptocomm.com

