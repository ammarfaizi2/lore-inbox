Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTEaOoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbTEaOoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:44:24 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:42119 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S264343AbTEaOoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:44:23 -0400
Date: Sat, 31 May 2003 07:50:26 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Artemio <artemio@artemio.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Xeon processor support
In-Reply-To: <200305311231.06582.artemio@artemio.net>
Message-ID: <Pine.LNX.4.44.0305310745460.31933-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Artemio wrote:
> 
> > Outside that what issues are you seeing?
> No issues. 
> I just know that Intel Xeon and Intel Pentium 4 Xeon are different things, 
> that's why I was asking - there is only a "Pentium 4" option in kernel 
> config.

Actually they aren't significantly different.

this is a prestonia core xeon:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2799.786
cache size      : 512 KB
Physical processor ID   : 0
Number of siblings      : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 5556.67

kernel currently use was compiled for pentium II/III

Linux hammer 2.4.18-24.8.0smp #1 SMP Fri Jan 31 06:03:47 EST 2003 i686 
i686 i386 GNU/Linux
 
> 
> Thanks for reply.
> 
> 
> Artemio.
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


