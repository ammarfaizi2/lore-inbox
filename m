Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267567AbSLFHwn>; Fri, 6 Dec 2002 02:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLFHwn>; Fri, 6 Dec 2002 02:52:43 -0500
Received: from holomorphy.com ([66.224.33.161]:22670 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267567AbSLFHwm>;
	Fri, 6 Dec 2002 02:52:42 -0500
Date: Fri, 6 Dec 2002 00:00:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50-bk5-wli-1
Message-ID: <20021206080009.GB11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.50-wli-bk5-1  fix driverfs oops wrt. memblks and nodes
2.5.50-wl-bk5i-2  __do_SAK() pidhash conversion
2.5.50-wli-bk5-3  introduce nr_processes() for proc_fill_super()
2.5.50-wli-bk5-4  hugetlbfs compilefix
2.5.50-wli-bk5-5  capset_set_pg() pidhashing conversion
2.5.50-wli-bk5-6  vm86 fixes
2.5.50-wli-bk5-7  UML get_task() pidhash conversion
2.5.50-wli-bk5-8  i386 discontigmem boot speedup
2.5.50-wli-bk5-9  allocate node-local pgdats for i386 discontigmem
2.5.50-wli-bk5-10 remove __has_stopped_jobs ()
2.5.50-wli-bk5-11 NUMA-Q PCI workarounds
2.5.50-wli-bk5-12 resize inode cache wait table -- 8 is too small

vs. 2.5.50-bk5. Available from:

ftp://ftp.kernel.org/pub/linux/kernel/pub/linux/kernel/people/wli/kernels/2.5.50-bk5-wli-1/

The "theme" of this patchset is basically my pending patch queue, minus
some already-akced-or-included-by-driver-maintainer cleanups. -bk5 is
not included in the supplied patches; apply beforehand.

Bill
