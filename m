Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVHaVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVHaVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVHaVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:49:57 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:19204 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932524AbVHaVtz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:49:55 -0400
Date: Wed, 31 Aug 2005 14:49:53 -0700
Message-Id: <200508312149.j7VLnrE4003130@zach-dev.vmware.com>
Subject: [PATCH 0/2] Trivial cleanups to virtualization tree
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 31 Aug 2005 21:50:00.0312 (UTC) FILETIME=[EF89CF80:01C5AE75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not very much of importance here, but the idea for these cleanups
came along during discussion of my last set of patches with Chris
Wright.

One cleans up whitespace, another improves understandability of
the mysterious +/- 1's in the page table init code.

Zachary Amsden <zach@vmware.com>
