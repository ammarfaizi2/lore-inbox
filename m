Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUIWO6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUIWO6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUIWO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:58:45 -0400
Received: from [202.125.86.130] ([202.125.86.130]:33971 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S266896AbUIWO6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:58:38 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Is it user process accessible address pointer?
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 23 Sep 2004 20:31:09 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107DDB@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is it user process accessible address pointer?
thread-index: AcShfV1wYqTpL6QFQfqCVpaqa37Rgw==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I got an address pointer from mmap system call is 0x40c23000. Is it user
space address? 
Is user application can directly access it?

System configuration is:

Intel Architecture 32 bit address space.
Red Hat Linux 7.3 with 2.4.18-3 kernel version.

Any help greatly appreciated.

Thanks and regards,

Srinivas G
