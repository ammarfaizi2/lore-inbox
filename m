Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTDKWwP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTDKWwO (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:52:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbTDKWwL (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:52:11 -0400
Date: Fri, 11 Apr 2003 16:03:55 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67-osdl1
Message-Id: <20030411160355.40518500.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://prdownloads.sourceforge.net/osdldcl/patch-2.5.67-osdl1.bz2?download

or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.67-1	PLM # 1771

No new features, just re-merge of existing set.

o Atomic 64 bit i_size access		(Daniel McNeil)
o Cpu Hot Plug				(Zwane Mwaikambo)
o Pentium Performance Counters		(Mikael Pettersson)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
o Kernel Config (ikconfig)		(Randy Dunlap)
o Improved boot time TSC synchronization (Jim Houston)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)


Dropped:
o Linux Kernel Crash Dump (LKCD)
	Touches too many places, not likely for 2.6 or distros in
	current form and under active development of new features.

o Expanded dev_t enabling
	Will re-examine when next version of 32-bit dev_t patches
	comes out.



