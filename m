Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTLSQbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLSQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:31:11 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:22418 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263462AbTLSQbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:31:06 -0500
Subject: [2.6.0 cpufreq] longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071851531.9835.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Dec 2003 17:32:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I insert the longhaul cpufreq module on my VIA EPIA 800 the system
completely freezes. It does not give any oops or other helpful error
message.

Through ACPI I can only use the throttling function, I can not switch
between 400 and 800 MHz.

Jurgen

output of /proc/cpu

processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Ezra
stepping        : 8
cpu MHz         : 800.048
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1595.80


