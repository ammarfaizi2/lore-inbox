Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264681AbUD1Hns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264681AbUD1Hns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbUD1Hns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:43:48 -0400
Received: from [202.125.86.130] ([202.125.86.130]:29831 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264681AbUD1Hnp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:43:45 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SMP kernel network problem
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 28 Apr 2004 13:03:48 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9721D6D54@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP kernel network problem
Thread-Index: AcQs8yTtWnF7J//jSCeFPN4MT6yI4A==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are using P4 HT Processor, RealTech 8139 Network card, Redhat 9.0
Kernel version 2.4.20-8smp.

When the system is booting form uni processor mode, I am able to ping
other systems in the network. But when I boot in SMP mode I am not able
to ping remote systems and am able to self ping. What may be the
problem? Is there any hardware problem? Is there any OS problem? 

If any body knows about it please let me know.

Thanks and regards,

Srinivas G


