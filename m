Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUCSL4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 06:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUCSL4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 06:56:16 -0500
Received: from [202.125.86.130] ([202.125.86.130]:26064 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262784AbUCSL4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 06:56:15 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Is there any difference between SMP makefile and non SMP makefile
Content-Transfer-Encoding: 8BIT
Date: Fri, 19 Mar 2004 17:22:09 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A972176922@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there any difference between SMP makefile and non SMP makefile
thread-index: AcQNqJub8PsSOEEVQvWP2otOUr4MXg==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am using Red Hat Linux 7.3, Kernel is 2.4.18-3smp and kernel 2.4.18-3
under Intel HT processor. 

Is there any difference between SMP Makefile and non SMP Makefile. I
have Makefile for non SMP system. What macros OR what flags can I add to
the existing Makefile to compile it on 2.4.18-3smp kernel. It is working
fine under 2.4.18-3 kernel that is non-SMP system.

Thanks in advance.

---Srinivas G

