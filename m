Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265241AbTLRSES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLRSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 13:04:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:48530 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265241AbTLRSER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 13:04:17 -0500
Subject: Linux 2.6.0 durability test using OSDL-DBT-3
From: Jenny Zhang <jenny@osdl.org>
To: linnux-quality <linux-quality@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: osdl
Message-Id: <1071770839.12786.5.camel@ibm-a.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Dec 2003 10:07:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To test Linux 2.6.0 durability, we stressed the OS under OSDL-DBT-3
workload for 14 days.

During the test, we did not see any kernel failure.  Linux 2.6.0 passed
the durability test under OSDl-DBT-3 workload.  However, we did wee
performance degradation throughout the test.

For detail of the test, see
http://developer.osdl.org/jenny/durability2.6/

If you have any questions/suggestions about the test, please let us
know.

-- 
Jenny Zhang
Open Source Development Lab
12725 SW Millikan Way, Suite 400
Beaverton, OR 97005
(503)626-2455 ext 31


