Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUJSFpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUJSFpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUJSFpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:45:04 -0400
Received: from [202.125.86.130] ([202.125.86.130]:14797 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S268005AbUJSFpB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:45:01 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: DMA memory allocation --how to  more than 1 MB 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 19 Oct 2004 11:18:13 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811175F32@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DMA memory allocation --how to  more than 1 MB 
Thread-Index: AcS1ndkEBTGBaHpLQjGhRQ1I49Gd2w==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a doubt about allocating the DMA memory using kmalloc OR
__get_dma_pages OR pci_alloc_consistent. I was unable to allocate the
memory greater than 1 MB using any one of the above memory functions. 

Is there any other method which will allocate the DMA memory greater
than 1 MB?

My system configuration is: Red Hat 7.3 with 2.4.18-3 kernel version on
IA32 platform. 

Thanks and regards,
Srinivas G

