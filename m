Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUG2Ce1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUG2Ce1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2Ce1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:34:27 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:51317 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S267424AbUG2CeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:34:24 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Jeremy Fitzhardinge'" <jeremy@goop.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [cpufreq][2.6.8-rc2-bk#] - New CPU unspported info for IBM ThinkPad T42
Date: Wed, 28 Jul 2004 22:34:37 -0400
Message-ID: <000101c47514$97b5b440$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.80GHz
stepping        : 6
cpu MHz         : 1798.941
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr mce cx8 apic sep mtrr pge mca cmov pat
clflush dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
bogomips        : 3563.52

-----

speedstep-centrino: found unsupported CPU with Enhanced SpeedStep: send
/proc/cpuinfo to Jeremy Fitzhardinge <jeremy@goop _DOT_ org>
cpufreq: CPU0 - ACPI performance management activated.
cpufreq:  P0: 1800 MHz, 21000 mW, 500 uS
cpufreq:  P1: 1600 MHz, 19000 mW, 500 uS
cpufreq:  P2: 1400 MHz, 16500 mW, 500 uS
cpufreq:  P3: 1200 MHz, 14500 mW, 500 uS
cpufreq:  P4: 1000 MHz, 12000 mW, 500 uS
cpufreq:  P5: 800 MHz, 10000 mW, 500 uS
cpufreq: *P6: 600 MHz, 7500 mW, 500 uS
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available

