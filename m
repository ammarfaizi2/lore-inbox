Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTFLS3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTFLS3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:29:31 -0400
Received: from ip68-2-19-97.ph.ph.cox.net ([68.2.19.97]:51387 "EHLO
	dent.deepthot.org") by vger.kernel.org with ESMTP id S264928AbTFLS3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:29:30 -0400
From: Jay Denebeim <denebeim@deepthot.org>
X-Newsgroups: dt.kernel
Subject: lockup on USB event kernel 2.4.20
Date: Thu, 12 Jun 2003 18:17:38 +0000 (UTC)
Organization: Deep Thought
Message-ID: <slrnbehgu2.e60.denebeim@dent.deepthot.org>
X-Complaints-To: news@deepthot.org
User-Agent: slrn/0.9.7.4 (Linux)
To: linuxkernel@deepthot.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My SO's computer works fine under redhat 8 which runs on a 2.4.18
kernel, however on redhat 9 with a 2.4.20 kernel it locks up.  Also,
redhat upgraded their kernel to 2.4.20 for rh 8 as well and I saw the
same behavior.

Everything works fine until she moves her mouse which is connected to
the USB, that locks the system.

Is this a known problem?  Any idea how I can debug it?

Thanks
Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
