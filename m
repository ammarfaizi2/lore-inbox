Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUAQKmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUAQKmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:42:06 -0500
Received: from mail3.cc.huji.ac.il ([132.64.1.21]:8377 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S266035AbUAQKmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:42:03 -0500
Message-ID: <4007C00E.3040603@mscc.huji.ac.il>
Date: Fri, 16 Jan 2004 12:42:22 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: David Ford <david+hb@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown CPU
References: <40083E96.3020109@blue-labs.org>
In-Reply-To: <40083E96.3020109@blue-labs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
You have the same CPU like me.
I have the EPox mobo and I had this issue.
If your bios ver is not 10/17/2003 then update it from the net.

David Ford wrote:

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
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


