Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVAGVDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVAGVDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVAGVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:01:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:20642 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261603AbVAGU7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:59:32 -0500
Subject: [ANNOUNCE] January Release of LTP now available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF74E862F6.E9AD284F-ON85256F82.00732E51-86256F82.00733BFC@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Fri, 7 Jan 2005 14:59:16 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF6|December 9, 2004) at
 01/07/2005 15:59:24
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






LTP-20050107
- Porting changes from John Kohl to help support compatablility LTP on
Solaris, HP-UX and AIX.
- Add scsi virtual devices testsuite using scsi_debug
- Changes to fix defect 13205 - testcase (seg fault) fails when
MALLOC_CHECK_=3 environment varible is turned on .
  Removed test for ppc64 as special exception, now passes
child_stack+CHILD_STACK_SIZE as parameter to clone on ppc64
- Applied patch from Prashant Yendigeri that fixes execution path problem.
- Fix for defect 11968 - test seg faults on a SMP system (8-way)
- Removed a prior applied patch from getdents01, that broke the testcases.
- Applied patch from Ricky Ng-Adam to fix ioperm01 testcase.
- Applied patch from Jacky Malcles for madvise02.
- Applied fixes to error messages from Adam Lackorzynski.waitpidXX
- Applied cleanup patch from Prashant Yendigeri for writexx testcases.

Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

