Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267877AbTBLWLS>; Wed, 12 Feb 2003 17:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267879AbTBLWLS>; Wed, 12 Feb 2003 17:11:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267877AbTBLWLR>;
	Wed, 12 Feb 2003 17:11:17 -0500
Subject: 2.5.60-dcl2
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045088466.22241.38.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Feb 2003 14:21:06 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.60-dcl2 is available at
        http://sourceforge.net/projects/osdldcl

or BitKeeper 
       Common          bk://bk.osdl.org/linux-2.5-osdl
           + DCL:      bk://bk.osdl.org/linux-2.5-dcl

or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.60	ID 1476
	dcl-2.5.60      ID 1477


2.5.60-osdl2:
* CFQ disk scheduler			(Jens Axboe)
* Oprofile support for P4		(John Levon)
* Pentium Performance Counters		(Mikael Pettersson)
* Megaraid 2 driver                   	(Matt Domsch)
* Kernel Probes (kprobes)               (Rusty Russell)
* Linux Kernel Crash Dump (LKCD)        (Matt Robinson, LKCD team)
  Have NOT incorporated latest kexec changes.
* Linux Trace Toolkit (LTT)             (Karim Yaghmour)
* Kernel Config (ikconfig)		(Randy Dunlap)
        
2.5.60-dcl2:
* Improved boot time TSC synchronization (Jim Houston)
* Bug fix for flock and threads		(Matthew Wilcox)
* RCU statistics               		(Dipankar Sarma)
* Scheduler tunables            	(Robert Love)

2.5.60-dcl1 was never publicly announced because of
problems found during testing.

Project information:
        http://www.osdl.org/projects/dcl/


