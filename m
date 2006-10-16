Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422818AbWJPTJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWJPTJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWJPTJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:09:07 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:41213 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1422818AbWJPTJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:09:05 -0400
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Date: Mon, 16 Oct 2006 12:02:04 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6E5@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when
 update pos for vector and offset
Thread-Index: AcbxUiBVxuYFuta9TTyuk6EUKOOcrgAA1l4Q
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>
cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 16 Oct 2006 19:02:05.0622 (UTC)
 FILETIME=[92555D60:01C6F155]
X-WSS-ID: 692D08A70CK4435867-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: using irq_domain in ioapic_retrigger_irq

http://lkml.org/lkml/2006/10/14/37

YH


