Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVDTIA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVDTIA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDTIA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:00:58 -0400
Received: from hippo.bbaw.de ([194.95.188.1]:29086 "EHLO hippo.bbaw.de")
	by vger.kernel.org with ESMTP id S261476AbVDTIAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:00:34 -0400
Date: Wed, 20 Apr 2005 10:00:28 +0200
From: Lars =?ISO-8859-1?Q?T=E4uber?= <taeuber@bbaw.de>
To: linux-kernel@vger.kernel.org
Subject: AMD Mobile Sempron and kernel config
Message-Id: <20050420100028.58d0bea8.taeuber@bbaw.de>
Organization: Berlin-Brandenburgische Akademie der Wissenschaften
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: $m?PFk6wE"V7Z'zo[qGjmU`'e-.z<d}U1{c}ZpYC~B1JbDgvsc$1@rb`P}+NO=bhd&WWX(1
 7A;9Zx%|<nen9jM}>"vm$m8h(I%pLt}-H\eozx_CYh2{0agi%xk~qjl.Y
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-14; AVE: 6.30.0.7; VDF: 6.30.0.116; host: bbaw.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo there,

hopefully my message is not to disturbing.
We own a notebook with a mobile sempron processor.
Which CPU choice is the one we should take?

CONFIG_MK7 or CONFIG_MK8 ?

Of course it's for a 32bit kernel.

Here is the output of /proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 28
model name      : Mobile AMD Sempron(tm) Processor 2800+
stepping        : 0
cpu MHz         : 800.190
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext fxsr_opt 3dnowext 3dnow lahf_lm
bogomips        : 1589.24


Thanks alot
Lars
