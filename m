Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCQJVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 04:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUCQJVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 04:21:17 -0500
Received: from [202.125.86.130] ([202.125.86.130]:52671 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261232AbUCQJVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 04:21:16 -0500
Content-class: urn:content-classes:message
Subject: Interrupt Handling on SMP
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 17 Mar 2004 14:47:30 +0530
Message-ID: <1118873EE1755348B4812EA29C55A972176734@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interrupt Handling on SMP
Thread-Index: AcQMAKyHTCZVd5dEQ9GUKsM61OFNqQ==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi All,
I have a device driver which runs on Uni-processor without any problem. 
When I run the same on SMP machine Interrupt handler is not invoked 
i.e. interrupt is not hooked. All other things are fine.

What could be the problem and what should I do to make it work.....
Thanks in advance
---chandra
