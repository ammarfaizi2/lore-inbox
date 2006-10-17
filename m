Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJQRgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJQRgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWJQRgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:36:00 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:62858 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751363AbWJQRf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:35:59 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64: using irq_domain in ioapic_retrigger_irq
Date: Tue, 17 Oct 2006 10:28:17 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D6F3@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: using irq_domain in ioapic_retrigger_irq
Thread-Index: AcbyDzk/FiEMEu7xTq+Oa5rAG5C3SwAAjuSg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 17 Oct 2006 17:28:18.0647 (UTC)
 FILETIME=[A2CEDE70:01C6F211]
X-WSS-ID: 692BCD380C44734070-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good, So need to find out the correct mask for irq ever used.



