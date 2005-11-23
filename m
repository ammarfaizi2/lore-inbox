Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbVKWIjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbVKWIjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVKWIjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:39:02 -0500
Received: from math.ut.ee ([193.40.36.2]:17119 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1030366AbVKWIjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:39:00 -0500
Date: Wed, 23 Nov 2005 10:38:58 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: MTRR compile failure in git
Message-ID: <Pine.SOC.4.61.0511231037390.13524@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC      arch/i386/kernel/cpu/mtrr/main.o
arch/i386/kernel/cpu/mtrr/main.c: In function 'set_mtrr':
arch/i386/kernel/cpu/mtrr/main.c:225: error: 'ipi_handler' undeclared (first use in this function)
arch/i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only oncearch/i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)

x86 UP i686 (PIII)

-- 
Meelis Roos (mroos@linux.ee)
