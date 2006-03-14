Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWCNIIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWCNIIB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWCNIIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:08:01 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:24294 "EHLO max.feld.cvut.cz")
	by vger.kernel.org with ESMTP id S1751783AbWCNIIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:08:00 -0500
From: CIJOML <cijoml@volny.cz>
To: linux-kernel@vger.kernel.org
Subject: Dmesg is not showing whole boot list
Date: Tue, 14 Mar 2006 09:01:27 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140901.27746.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

maybe this si a wrong list to ask, bug after boot, dmesg shows that few lines 
at the beginning are missing.

Is there any option I can increase to get full dmesg?

ine.. 4801.43 BogoMIPS (lpj=2400718)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 
00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c88)
.
.
.

Linux Debian testing, kernel 2.6.16-rc5

Thanks for reply a regards

Michal
