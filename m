Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268904AbTBSOCp>; Wed, 19 Feb 2003 09:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbTBSOCp>; Wed, 19 Feb 2003 09:02:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12172 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268904AbTBSOCo>; Wed, 19 Feb 2003 09:02:44 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302191412.h1JECmG25452@devserv.devel.redhat.com>
Subject: Linux 2.2.24-rc4
To: linux-kernel@vger.kernel.org
Date: Wed, 19 Feb 2003 09:12:47 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.2.24-rc4
o	Fix ethernet as modules problems		(me)
o	Fix 8139too and rtl8139 padding			(me)

Linux 2.2.24-rc3
o	Backport the ethernet padding fixes		(me)
	| All done except 8139too, rtl8139]

Linux 2.2.24-rc2

o	Apply AMD fix correctly				(Bruce Robson)
o	Fix possible memory scribble in starfire	(Ion Badulescu)

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
