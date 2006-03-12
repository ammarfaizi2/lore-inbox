Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWCLKgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWCLKgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWCLKgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:36:52 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23270
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751394AbWCLKgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:52 -0500
Message-Id: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:12 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 0/8] hrtimer updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

please take the following patchset into -mm.

It contains most of the yet unapplied patches of Romans earlier 
patchset. I reworked some bits and fixed SMP and userspace return 
value issues.

	tglx
--

