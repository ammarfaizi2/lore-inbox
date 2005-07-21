Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVGUJL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGUJL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVGUJL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:11:56 -0400
Received: from [202.125.86.130] ([202.125.86.130]:22193 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261708AbVGUJL4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:11:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: 2.6 kernel timespec nano sec howto
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 21 Jul 2005 14:23:34 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB3481161130C@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-topic: 2.6 kernel timespec nano sec howto
Thread-index: AcWN0+wczOQRC8jmQ5CGBCat1Ky8cw==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Cc: "Richard B. Johnson" <linux-os@analogic.com>,
       "Richard B. Johnson" <linux-os@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have timing issue in my code powering up my socket device.
I want use the current_kernel_time() and wait in terms of nano seconds.
The tv_nsec (nano) of timespec structure will be overflowing every
second.
So, how do I handle it?

Regards,
Mukund Jampala
