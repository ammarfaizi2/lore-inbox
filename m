Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWIHVjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWIHVjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIHVjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:39:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18561 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751177AbWIHVjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:39:19 -0400
Date: Fri, 8 Sep 2006 17:39:17 -0400
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext4 development <linux-ext4@vger.kernel.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060908213914.11498.3272.sendpatchset@kleikamp.austin.ibm.com>
Subject: [RFC:PATCH 000/002] EXT3: cleanups in preparation for ext4 clone
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on rebasing Mingming's ext4 patches on the -mm tree, and have
noticed a couple cleanups that would be nice to have in ext3 before the
code diverges.

Thanks,
Shaggy

-- 
David Kleikamp
IBM Linux Technology Center
