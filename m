Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSLPUKn>; Mon, 16 Dec 2002 15:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSLPUKn>; Mon, 16 Dec 2002 15:10:43 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41245 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261218AbSLPUKm>; Mon, 16 Dec 2002 15:10:42 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200212162018.gBGKIdP18149@devserv.devel.redhat.com>
Subject: Linux 2.2.24-rc1
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2002 15:18:39 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.2.24-rc1

o	Fix a typo in the maintainers			(James Morris)
o	Dave Niemi has moved				(Dave Niemi)
o	Fix incorrect blocking on nonblock pipe		(Pete Benie)
o	Fix misidentification of some AMD processors	(Bruce Robson)
o	Fix a very obscure skb_realloc_headroom bug	(James Morris)
o	Fix warning in lance driver			(Thomas Cort)
o	Fix sign handling bug in pms driver		(Silvio Cesare)
o	Drop mmap on /proc/<pid>/mem as 2.4/2.5 did	(Michal Zalewski)
	(also fixes some bugs)
