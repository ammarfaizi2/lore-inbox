Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbSIPQak>; Mon, 16 Sep 2002 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSIPQak>; Mon, 16 Sep 2002 12:30:40 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26322 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262468AbSIPQaj>; Mon, 16 Sep 2002 12:30:39 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209161635.g8GGZaV18210@devserv.devel.redhat.com>
Subject: Linux 2.2.22
To: linux-kernel@vger.kernel.org
Date: Mon, 16 Sep 2002 12:35:36 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.22
o	Fix HDLC bugs causing kernel printk warns	(Pavel)

2.2.22-rc3
o	3ware IDE raid small update			(Adam Radford)
o	Fix incorrect comments				(Solar Designer)
o	Sanity check in isdn 				(Solar Designer)
o	Type fixes for usb				(Solar Designer)
o	Vmalloc corner case fix 			(Dave Miller)

2.2.22-rc2
o	Fix isofs over loopback problems		(Balazs Takacs)
o	Backport 2.4 shutdown/reset SIGIO from 2.4	(Julian Anastasov)
o	Fix error reporting in OOM cases		(Julian Anastasov)
o	List a 2.2 maintainer in MAINTAINERS		(Keith Owens)
o	Set atime on AF_UNIX sockets			(Solar Designer)
o	Restore SPARC MD boot configuration		(Tomas Szepe)
o	Multiple further sign/overflow fixes		(Solar Designer)
o	Fix ov511 'vfree in interrupt'			(Mark McClelland)

2.2.22-rc1
o	Backport 2.4 neighbour sending fix		(Chris Friesen)
o	Fix a sign handling slackness in apm		(Silvio Cesare)
o	Fix a sign handling error in rio500		(Silvio Cesare)
o	Indent depca ready for cleanups			(me)
o	Update VIA C3 recognition			(Diego Rodriguez)
o	Fix a sysctl handling bug			(MIYOSHI Kazuto)
o	Fix a netlink error handling bug in ipfw	(Alexander Atanasov)
o	3ware IDE RAID update				(Adam Radford)
o	Note ioctl clash on 0x5402			(Pavel Machek)
o	Typo fix					(Dan Aloni)
o	Update Riley's contact info			(Riley Williams)
o	Alpha ptrace fixes				(Solar Designer)
o	Multiple security fix backports			(Solar Designer)
