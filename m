Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFHOCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFHOCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFHOCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:02:03 -0400
Received: from general.keba.co.at ([193.154.24.243]:26008 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261240AbVFHOCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:02:00 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Date: Wed, 8 Jun 2005 16:02:01 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323235@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Thread-Index: AcVsHgEsN/s7rU83SkSYq34h21ECbAAE+Y/w
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have released the -V0.7.48-00 Real-Time Preemption patch, 
[snip]
> be affected that much (besides possible build issues). Non-x86 arches
> wont build. Some regressions might happen, so take care..

What arches are likely to work in the near future?
I've seen that "Kconfig.RT" is sourced for i386, x86_64, ppc, 
and mips, but not for arm.

arm is one of the platforms we are interested in, any chances?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
