Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268550AbUHLT3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268550AbUHLT3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbUHLT3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:29:41 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:59858 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S268550AbUHLT3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:29:38 -0400
Subject: UDF status
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux_udf@hpesjro.fc.hp.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1092338911.4207.25.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2004 13:28:31 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Aug 2004 19:29:37.0143 (UTC) FILETIME=[B4503870:01
	C480A2]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:6.63617 C:20 M:0 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UDF "Development Status" remains "5 - Production/Stable" but includes
the following new issues, now recorded at:

http://sourceforge.net/projects/linux-udf
http://sourceforge.net/tracker/?group_id=295&atid=100295

To fix these we need volunteers able to write patches, of course. 
People with less expertise can work to make any of these more plainly
reproducible, e.g. by writing a demo test script.

--- hi priority

1008156 multi-session starts where
1008134 holes above 1 GiB

--- medium priority

1008140 files above 2 GiB

--- low priority

1008188 big-endian mkudffs goes boom
1008152 fsck fails after mkfs
1008186 fsck fails after shrink
1008131 lookup vs. wide chars
1008176 mkudffs does not read and compare
1008174 mkudffs option= help not given
1008172 mkudffs not interoperable by default
1008162 -o lastblock= needed to mount bootable ISO/UDF
1008184 phgfsck chokes over /dev/scd$n

---

Pat LaVarre
http://udfko.blog-city.com/read/585696.htm


