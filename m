Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUAPUBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbUAPUBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:01:10 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:15497 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S265833AbUAPUA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:00:26 -0500
Date: Fri, 16 Jan 2004 11:59:31 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: David Ford <david+hb@blue-labs.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown CPU
In-Reply-To: <40083E96.3020109@blue-labs.org>
Message-ID: <Pine.LNX.4.44.0401161158180.32303-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's clearly a barton, what kernel are you running?

joelja

On Fri, 16 Jan 2004, David Ford wrote:

> I've an unknown cpu (athlon xp) in my machine.  What data do I need to 
> collect so the kernel knows what it is?
> 
> # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : Unknown CPU Type
> stepping        : 0
> cpu MHz         : 1837.618
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
> mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 3629.05
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


