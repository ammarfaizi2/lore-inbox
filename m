Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267784AbRGQHE4>; Tue, 17 Jul 2001 03:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbRGQHEr>; Tue, 17 Jul 2001 03:04:47 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:39046 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267782AbRGQHEm>; Tue, 17 Jul 2001 03:04:42 -0400
From: r1vamsi@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, dprobes@oss.lotus.com, ltc@linux.ibm.com,
        mark.j.sullivan@intel.com, zhi-tao_guo@agilent.com
cc: hanrahat@us.ibm.com, vksuktha@in.ibm.com
Message-ID: <CA256A8C.0026CB44.00@d73mta01.au.ibm.com>
Date: Tue, 17 Jul 2001 12:31:44 +0530
Subject: [Announce[ Dynamic Probes 2.2.0
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DProbes 2.2.0 is released

Dynamic Probes is a generic and pervasive debugging facility that will
operate under the most extreme software conditions such as debugging a deep
rooted operating system problem in a live environment.

Brief changelog:
- patch for kernel version 2.4.6.
- new --dont-verify-opcodes
- can work even if pre-processor is not present at runtime.
- reduce dp_interpreter kernel stack usage (remove inline functions)
- move arch-dependent stuff out of kernel/dprobes.c

Download:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: r1vamsi@in.ibm.com


