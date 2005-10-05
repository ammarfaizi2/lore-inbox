Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVJELpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVJELpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVJELpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:45:04 -0400
Received: from spirit.analogic.com ([204.178.40.4]:51728 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965112AbVJELpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:45:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1128511676.2920.19.camel@laptopd505.fenrus.org>
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 05 Oct 2005 11:45:02.0285 (UTC) FILETIME=[38AFAFD0:01C5C9A2]
Content-class: urn:content-classes:message
Subject: Re: freebox possible GPL violation
Date: Wed, 5 Oct 2005 07:45:02 -0400
Message-ID: <Pine.LNX.4.61.0510050738420.1555@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: freebox possible GPL violation
Thread-Index: AcXJojjMGgczsqahSLWkAMUh2ii1ZA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Emmanuel Fleury" <fleury@cs.aau.dk>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Arjan van de Ven wrote:

>
>> Your task will be to prove that the kernel they upload to your box is a
>> modified Linux kernel (by "modified Linux kernel", I mean no modules but
>> the kernel itself).
>>
>> So, the first step would be to catch/sniff this binary image, then
>> analyze it.
>>
>> But, as long as you cannot prove that Free has done internal
>> modifications to the Linux kernel which are not released in any way,
>> your case is quite thin.
>
> why?
>
> The GPL holds modified or not...
>
> (and that includes drivers if they are distributed together with the gpl
> kernel as part of a bigger work)

The unmodified kernel and the unmodified drivers are available
from ftp.kernel.org and other sources, the vendor doesn't have
to supply them, only tell you where you can get them if you want them.

Anything the vendor wrote in user-space is the vendor's own stuff.
The vendor doesn't have to supply them at all.

Transparently upgrading across the network is a pretty good idea.
It seems that the "secret" protocol they are using pissed you off
so you think they must be doing something wrong.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
