Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWE3RQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWE3RQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWE3RQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:16:45 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:27079 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932348AbWE3RQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:16:45 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Message-Id: <20060530171642.27305.38862.sendpatchset@skynet>
Subject: [PATCH 0/2] Compile problems on ia64 with 2.6.17-rc5-mm1
Date: Tue, 30 May 2006 18:16:42 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc5-mm1 had some minor compile problems on IA64. The following two
patches should address them.
-- 
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
