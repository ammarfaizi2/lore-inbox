Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTCCPtd>; Mon, 3 Mar 2003 10:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbTCCPtc>; Mon, 3 Mar 2003 10:49:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62742 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266095AbTCCPta>; Mon, 3 Mar 2003 10:49:30 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303031559.h23FxvJ24764@devserv.devel.redhat.com>
Subject: Linux 2.2.24-rc5
To: linux-kernel@vger.kernel.org
Date: Mon, 3 Mar 2003 10:59:57 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this should be it

Linux 2.2.24-rc5
o	Fix n_hdlc globals pollution			(Paul Fulghum)
o	Fix initialisation of sk->sleep			(Holger Smolinksi)
o	Handle init_ethdev returning null in tulip	(Neale Banks)
o	Backport rtc wildcard fix to 2.2		(Paul Gortmaker)
o	Correct wireless config help			(Neale Banks)
o	Fix smc9194 build				(me)

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
