Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUKEUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUKEUaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUKEUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:30:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:5305 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261203AbUKEUad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:30:33 -0500
Subject: [ANNOUNCE] November Release of LTP now available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9A8067AC.FD841BC2-ON85256F43.007080C4-86256F43.0070A7F9@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Fri, 5 Nov 2004 14:30:30 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.3 HF1|October 13, 2004) at
 11/05/2004 15:30:30
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





ChangeLog from the November LTP release:

LTP-20041105
- Added extensive syscall testsuite (Ballista)
- Added new tests to EPoll testsuite
- Applied long path name patch from Michael Vieths
- Removed the requirement to have "." listed as the first directory, since
it is not a documented requirement.
- GetDents01 - Used _syscall3() to allow this test to run on non-x86 archs.
- Applied message formatting patch from Gordon Jin.
- Applied IA64 specific patch from Jacky Malcles.
- Fixes from Chris Wright for swapon02 failures
- Restored the compile settings for Linux2.4/GLIBC2.2 and created a new one
for Linux/GLIBC2.3 Removed -fwritable-strings
  and -DGLIBC=22 flags from compile.
- Applied a patch from Zhao Kai that added a pause to allow for testing on
installations with improved PAM security.


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

