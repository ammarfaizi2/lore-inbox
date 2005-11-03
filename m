Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbVKCUze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbVKCUze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbVKCUze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:55:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5574 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030477AbVKCUzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:55:33 -0500
Subject: [ANNOUNCE] November Release of LTP Available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OF3555E602.779AC2FF-ON852570AE.0072D43A-862570AE.0072EB1C@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 3 Nov 2005 14:55:27 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP2 | September 29, 2005) at
 11/03/2005 15:55:28
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LTP-20051103
- fix from Bryce Harrington to corect a Makefile and path problem on some
systems
- Updated aiocp to the latest level. See
http://developer.osdl.org/daniel/AIO/
- Corrected a logical typo in the mmapstress test found by John Clemens:
- Changes for cleanup of digsig testcases
- Applied patch from Jacky Malcles to allow the test to execute correctly
with
  the new 2.6 kernel.
- Fix for defect failure in fcntl23.c to lock readonly file, changed to
open file RDONLY
- Fix gethostid01 to return correct code in 64 bit mode
- fix madvise01 testcase error where it may not run out of memory
- Applied patch [ ltp-Bugs-1168107 ] from Shyam Chandrasekaran:
- Fix bug in settimer01.c
- Fix write04.c to work on ia64
- Cleanup to not include redundant sys/socket.h after linux/socket.h
- Add NetworkStress testcases from IBM Japan



Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

