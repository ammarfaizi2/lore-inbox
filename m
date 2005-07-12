Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVGLSsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVGLSsp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGLSso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:48:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12674 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261928AbVGLSsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:48:42 -0400
Subject: [ANNOUNCE] July Relase of LTP available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sf.net,
       ltp-announce@lists.sf.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OFAFB12DBD.88145D14-ON8525703C.00670C49-8625703C.00674C10@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Tue, 12 Jul 2005 13:48:29 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.53IBM1 HF14|April 18, 2005) at
 07/12/2005 14:48:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTP-20050707
- Applied fixes by Paul J.Y. Lahaie to implement support for UCLinux
- suppresses the warning  "head: `-1' option is obsolete; use `-n 1'..."
- Updated the TEST() macro to return long, instead of int for use with
64bit architectures.
- Removed umount04.
- Security updates for ppc and 390 systems
- The K42 open source operating system bug fix for panic when alarm is
cancelled.
- Applied some zSeries specific patches.
- Applied patches to allow NFSv4 testing:
- Define gettid() to syscall(__NR_gettid).

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

