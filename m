Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbTGDB3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbTGDB3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:29:42 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:35333 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265613AbTGDB3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:29:41 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.74-mm1 arch/i386/kernel/cpu/cpufreq/ Compile error
Date: Fri, 4 Jul 2003 09:13:08 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307031955.37384.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:67: incompatible types in assignment
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:78: incompatible type for argument 2 of `set_cpus_allowed'
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:90: incompatible type for argument 2 of `set_cpus_allowed'
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:131: incompatible type for argument 2 of `set_cpus_allowed'

Compilers which don't complain here are very sloppy.

Regards
Michael
-- 
Powered by linux-2.5.74-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp and ACPI S3
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt


