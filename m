Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWAEJv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWAEJv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWAEJv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:51:26 -0500
Received: from hulk.jobsahead.com ([202.138.125.174]:20950 "EHLO
	hulk.jobsahead.com") by vger.kernel.org with ESMTP id S1751206AbWAEJv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:51:26 -0500
Subject: High load
From: Aniruddh Singh <aps@jobsahead.com>
To: linux <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:19:57 +0530
Message-Id: <1136454597.6016.7.camel@aps.monsterindia.noida>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4.asl) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

I have one compaq server with 4 Intel(R) Xeon cpu's (3.1GHZ), 4GB RAM.
OS:- Fedora Core 2
Kernel:- 2.6.14

when i compile a new kernel, during th compilation process load goes
very high (10 and little above). i can not understand why does this
happen, while if i compile the same kernel on my P4 machine with 1GB ram
and 3GHZ, it remains under 3.

can somebody tell me what is wrong?
-

-- 
Regards
Aniruddh Singh
System Administrator
Monster.com India Pvt. Ltd.
FC 23, Block B, 1st Floor, Sector 16A
Film City Noida 201301 U.P.


