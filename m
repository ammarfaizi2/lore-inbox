Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKTQWA>; Wed, 20 Nov 2002 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKTQV7>; Wed, 20 Nov 2002 11:21:59 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61997 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261587AbSKTQV4>; Wed, 20 Nov 2002 11:21:56 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211201628.gAKGSwL03853@devserv.devel.redhat.com>
Subject: Linux 2.2.23-rc2
To: linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2002 11:28:58 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually include the DoS fix this time

2.2.23-rc2
o	Backport NT iret denial of service bugfix    (Marc-Christian Petersen)

2.2.23-rc1
o	Gameport support for ALi 5451			(Pascal Schmidt)
	| Just missing PCI idents
o	IP options IPOPT_END padding fix		(Jeff DeFouw)
o	Make APM check more paranoid			(Solar Designer)
o	Sanity check ixj requests as in 2.4		(Solar Designer)
o	Fix printk warning in fat			(Solar Designer)
o	Fix other print warnings in 2.2.22		(Solar Designer)
o	ISDN multichannel ppp locking fix		(Herbert Xu)
o	Fix sx driver compiled into kernel case		(Martin Pool)
o	Backport ipfw sleep in spinlock in firewall	(James Morris)
o	Update dmi_scan code to match 2.4/2.5		(Jean Delvare)
o	Make agp debugging printk clearer		(Neale Banks)

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
