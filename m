Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUBLQ1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUBLQ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:27:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:58827 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266510AbUBLQ1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:27:37 -0500
From: john cherry <cherry@osdl.org>
Date: Thu, 12 Feb 2004 08:27:35 -0800
Message-Id: <200402121627.i1CGRZe26110@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc2 - 2004-02-11.17.30) - 36 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ia64/sn/kernel/mca.c:42: warning: `print_hook' defined but not used
arch/ia64/sn/kernel/sn2/sn2_smp.c:117: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:117: warning: type defaults to `int' in declaration of `nix'
arch/ia64/sn/kernel/sn2/sn2_smp.c:119: warning: type defaults to `int' in declaration of `cnode'
arch/ia64/sn/kernel/sn2/sn2_smp.c:123: warning: type defaults to `int' in declaration of `data0'
arch/ia64/sn/kernel/sn2/sn2_smp.c:125: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:125: warning: type defaults to `int' in declaration of `ia64_intri_res'
arch/ia64/sn/kernel/sn2/sn2_smp.c:128: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:128: warning: initialization makes integer from pointer without a cast
arch/ia64/sn/kernel/sn2/sn2_smp.c:128: warning: type defaults to `int' in declaration of `ptc0'
arch/ia64/sn/kernel/sn2/sn2_smp.c:129: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:129: warning: initialization makes integer from pointer without a cast
arch/ia64/sn/kernel/sn2/sn2_smp.c:129: warning: type defaults to `int' in declaration of `ptc1'
arch/ia64/sn/kernel/sn2/sn2_smp.c:132: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:132: warning: type defaults to `int' in declaration of `ia64_intri_res'
arch/ia64/sn/kernel/sn2/sn2_smp.c:132: warning: type defaults to `int' in declaration of `mynasid'
arch/ia64/sn/kernel/sn2/sn2_smp.c:134: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:134: warning: type defaults to `int' in declaration of `ia64_intri_res'
arch/ia64/sn/kernel/sn2/sn2_smp.c:145: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:145: warning: type defaults to `int' in declaration of `ptc1'
arch/ia64/sn/kernel/sn2/sn2_smp.c:146: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:146: warning: parameter names (without types) in function declaration
arch/ia64/sn/kernel/sn2/sn2_smp.c:146: warning: type defaults to `int' in declaration of `pio_atomic_phys_write_mmrs'
arch/ia64/sn/kernel/sn2/sn2_smp.c:147: warning: data definition has no type or storage class
arch/ia64/sn/kernel/sn2/sn2_smp.c:147: warning: type defaults to `int' in declaration of `flushed'
arch/ia64/sn/kernel/sn2/sn2_smp.c:87: warning: unused variable `flushed'
arch/ia64/sn/kernel/sn2/sn2_smp.c:87: warning: unused variable `mynasid'
arch/ia64/sn/kernel/sn2/sn2_smp.c:87: warning: unused variable `nasid'
arch/ia64/sn/kernel/sn2/sn2_smp.c:88: warning: unused variable `ptc0'
arch/ia64/sn/kernel/sn2/sn2_smp.c:88: warning: unused variable `ptc1'
arch/ia64/sn/kernel/sn2/sn2_smp.c:89: warning: unused variable `data0'
arch/ia64/sn/kernel/sn2/sn2_smp.c:89: warning: unused variable `data1'
arch/ia64/sn/kernel/sn2/sn2_smp.c:89: warning: unused variable `flags'
arch/ia64/sn/kernel/sn2/sn2_smp.c:91: warning: unused variable `nasids'
arch/ia64/sn/kernel/sn2/sn2_smp.c:91: warning: unused variable `nix'
arch/ia64/sn/kernel/sn2/sn2_smp.c:98: warning: implicit declaration of function `for_each_cpu_mask'
