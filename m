Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUAFPTK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUAFPTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:19:10 -0500
Received: from mn.miryuna.net ([203.141.146.63]:37531 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264500AbUAFPTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:19:08 -0500
Subject: BIOS BUG: CPU#4 improperly initialized, has 3 usecs TSC skew! FIXED
From: David Alan Blomberg <dblomber@lpjam.com>
To: kernel <linux-kernel@vger.kernel.org>
Cc: dblomber@libertec.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Jan 2004 00:25:08 +0900
Message-Id: <1073402708.24101.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is Red Hat Advance server 2.1 
Kernel 2.4.9-e25
Hardware if IBM X360 
4 processors (Xeon 2.8 Hyperthreading enabled)
Summit Kernel

Question is the message appears to be a processor election problem (I
had it on 2 or the 8 reported processors-gotta love hyperthreading) It
is the only error I can locate and the system is acting up and hanging. 
IBM hardware error log only shows that "an unrecoverable error occured"
and system was rebooted.

Now for the question-is this serious? I have asked IBM for help but they
have no help (great thanks).  I also have another system (same build
showing only 1 like error at start up its not hanging like this one but
its not performing well).  Before you ask this is IBMs new X360 with the
faster BUS speed. 

Thank You in advance

David Blomberg   


