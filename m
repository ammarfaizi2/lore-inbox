Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCCLtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCCLtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCCLLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:11:30 -0500
Received: from [202.125.86.130] ([202.125.86.130]:16781 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261600AbVCCLCw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:02:52 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: problem with __get_dma_pages (failed to allocate memory)
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 3 Mar 2005 16:34:37 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB348113A456A@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problem with __get_dma_pages (failed to allocate memory)
Thread-Index: AcUf4MnkT4KyxuydStKakPyjfb8Vkg==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I have a doubt about __get_dma_pages. When I am trying to allocate the
memory to a DMA buffer using the __get_dma_pages it is failed. 

I am using the 2.4.18-3 kernel version? 
The System contains 128MB RAM. I tried with 256MB RAM also.

What are the reasons to fail the __get_dma_pages call?

Please give me some hints or advices or any links that are related to
it.
Thanks in advance.

Regards,
Srinivas G


