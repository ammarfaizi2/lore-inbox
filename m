Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWDXTk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWDXTk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDXTk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:40:27 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:41231 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751183AbWDXTk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:40:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
X-OriginalArrivalTime: 24 Apr 2006 19:40:24.0906 (UTC) FILETIME=[EE8602A0:01C667D6]
Content-class: urn:content-classes:message
Subject: Re: Compiling C++ modules
Date: Mon, 24 Apr 2006 15:40:24 -0400
Message-ID: <Pine.LNX.4.61.0604241537440.24459@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling C++ modules
thread-index: AcZn1u6p3vJbFl+xRVeTbAP2MyNMcQ==
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Gary Poppitz" <poppitzg@iomega.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Gary Poppitz wrote:

> I have the task of porting an existing file system to Linux. This
> code is in C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.
>
> I would be most willing to point out the areas that need adjustment
> and supply patch files to be reviewed.
>
> What would be the best procedure to accomplish this?

Rewrite the file-system in C. The kernel is written in 'C' and
assembly.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
