Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTDKK2V (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTDKK2V (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:28:21 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:1802 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP id S264324AbTDKK2U (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 06:28:20 -0400
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200304111040.h3BAe1806090@tellurium.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: bytesex.org -> censored (Was Re: 2.4.21-pre7: error compiling aic7(censored)/aicasm/aicasm.c)
In-Reply-To: <20030410171009$6b00@gated-at.bofh.it>
References: <20030406130015$057f@gated-at.bofh.it> <20030410171009$6b00@gated-at.bofh.it>
Date: Fri, 11 Apr 2003 20:40:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
>> <--  snip  -->
>> 
>> gcc-2.95 -D__KERNEL__ 
>> -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
>> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -D__KERNEL__ 
>> -I/home/bunk/linux/kernel-2.4/linux-2.4.21-pre7-full-nohotplug/include -e stext  
>> aicasm/aicasm.c   -o aicasm/aicasm
>> /usr/bin/ld: warning: cannot find entry symbol stext; defaulting to 08048760
> 
> This is probably due to the misplaced endif in the currently committed
> drivers/scsi/aic7xxx/Makefile.  Updated versions of the Makefile/driver
> can be found here:

Speaking of s/xxx/censored/, some moron decided at uni to block all
domains with sex in them. Any idea how to download v4l drivers of
www.bytesex.org? Concidering www.bytesex.org is vhosted, so one can't
use its IP address.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

So there you have it, supplicant. The Europeans aren't morally superior
to you [USAnians] at all. Just intellectually.       -- The Usenet Oracle
