Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUAPTno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUAPTno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:43:44 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:28347 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265280AbUAPTmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:42:18 -0500
Message-ID: <40083E96.3020109@blue-labs.org>
Date: Fri, 16 Jan 2004 14:42:14 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040109
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Unknown CPU
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've an unknown cpu (athlon xp) in my machine.  What data do I need to 
collect so the kernel knows what it is?

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Unknown CPU Type
stepping        : 0
cpu MHz         : 1837.618
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3629.05

