Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbTGST3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268557AbTGST3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:29:35 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12184 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266106AbTGST3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:29:35 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1-ac2 -- arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared  (first use in this function)
Date: Sat, 19 Jul 2003 12:44:31 -0700
User-Agent: KMail/1.5.9
Cc: paulus@au.ibm.com, benh@kernel.crashing.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307191244.31830.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/ppc/platforms/pmac_cpufreq.o
arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared (first 
use in this function)

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_PMAC=y
