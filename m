Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267366AbUHDS4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267366AbUHDS4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUHDS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:56:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47746 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267366AbUHDS4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:56:16 -0400
Subject: [ANNOUNCE] August release of LTP available
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFE82C602D.8F4E9D53-ON85256EE6.0067B9BF-86256EE6.0067EE18@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 4 Aug 2004 13:55:13 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|July 19, 2004) at
 08/04/2004 14:56:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The August release of the LTP testsuite is now available. Changes:

LTP-20040804
- Corrected TCbin definition.
- Changes to check for RedHat install when setting up environment variables
- Changed ROOT_PASSWORD to PASSWD to match other testcases.
- Change to check and exclude test if running on a 390 system since test is
invalid on that platform
- Fix build errors in modify_ldt01 and modify_ldt02
- Additional security testcases


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

