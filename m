Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTEGQJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTEGQJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:09:05 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264115AbTEGQJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:09:04 -0400
Date: Wed, 7 May 2003 09:21:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.69-osdl2
Message-Id: <20030507092138.77a0a032.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://prdownloads.sourceforge.net/osdldcl/patch-2.5.69-osdl2.bz2?download

or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.69-2	PLM # 1823

No new features, but this is a complete refresh of the contents.
The latest versions of all these patches have been incorported.

If you enable LTT then relayfs must be be built-in, not a module.
See:  http://www.opersys.com/relayfs/ltt-on-relayfs.html

o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
  includes relayfs
o Kexec 				(Eric Biederman, Andy Pfiffer)
o Lockmeter
o Atomic 64 bit i_size access		(Daniel McNeil)
o Pentium Performance Counters		(Mikael Pettersson)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)

