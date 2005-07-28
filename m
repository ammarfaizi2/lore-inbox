Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVG1MLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVG1MLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVG1MLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:11:54 -0400
Received: from spirit.analogic.com ([208.224.221.4]:21005 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261417AbVG1MLO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:11:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
References: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
X-OriginalArrivalTime: 28 Jul 2005 12:11:13.0177 (UTC) FILETIME=[72820890:01C5936D]
Content-class: urn:content-classes:message
Subject: Re: core file not generated when kernel is crashed with Sysrq key
Date: Thu, 28 Jul 2005 08:11:07 -0400
Message-ID: <Pine.LNX.4.61.0507280809420.14439@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: core file not generated when kernel is crashed with Sysrq key
thread-index: AcWTbXKo67BTjv/jTFCwukqmL2uHxQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "dipankar das" <dipankar_dd@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jul 2005, dipankar das wrote:

> Hi,
> core file is not generated when kernel is crashed with
> Sysrq key ?
>
> What could be the reason for this ?
>
>  Br,
>   Dipankar.

It's not supposed to write any 'core' file. A 'core' file is
a dump of users' virtual memory. It has nothing to do with
the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
