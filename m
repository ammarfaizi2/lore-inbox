Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWAPWBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWAPWBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWAPWBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:01:03 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:39685 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751225AbWAPWBB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:01:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200601162351.19159.jk-lkml@sci.fi>
X-OriginalArrivalTime: 16 Jan 2006 22:00:59.0830 (UTC) FILETIME=[55A5C560:01C61AE8]
Content-class: urn:content-classes:message
Subject: Re: Shared memory usage
Date: Mon, 16 Jan 2006 17:00:59 -0500
Message-ID: <Pine.LNX.4.61.0601161700260.27191@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Shared memory usage
Thread-Index: AcYa6FXOIhy2bUxATTSxcCTkwrvs8g==
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com> <200601162351.19159.jk-lkml@sci.fi>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Knutar" <jk-lkml@sci.fi>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Jan 2006, Jan Knutar wrote:

> On Monday 16 January 2006 16:15, linux-os (Dick Johnson) wrote:
>
>> /proc/meminfo does not show any shared memory in use!
>
> echo m > /proc/sysrq-trigger ; dmesg | grep shared
>
>> available in /proc as it was in the past before it was
>> removed.
>
> I think this was all over FAQs covering 2.4 -> 2.6 transition...
>

Thanks. That works.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
