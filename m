Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTKRPpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTKRPpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:45:15 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:34055 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263434AbTKRPpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:45:11 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: HT enable on BIOS which doesn't supports it?
Date: Tue, 18 Nov 2003 16:45:02 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311181645.02744.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, in my laptop Acer TravelMate242 I have HT enabled CPU,

but when I try start up with SMP or LocalAPIC kernel enabled, kernel freezes 
during boot time.

Is there any possibility to run HT enabled CPU on my laptop without BIOS 
support?

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2398.001
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.12

Thanks a lot

Michal

