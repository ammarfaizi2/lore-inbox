Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVKAVGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVKAVGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKAVGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:06:30 -0500
Received: from spirit.analogic.com ([204.178.40.4]:34825 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751228AbVKAVG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:06:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <5449aac20511011246r6ece9f18rb3b7353dbfc2dedb@mail.gmail.com>
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com> <200511012000.21176.mbuesch@freenet.de> <4367A990.2040301@utah-nac.org> <200511012012.32995.mbuesch@freenet.de> <5449aac20511011246r6ece9f18rb3b7353dbfc2dedb@mail.gmail.com>
X-OriginalArrivalTime: 01 Nov 2005 21:06:27.0593 (UTC) FILETIME=[1FD90790:01C5DF28]
Content-class: urn:content-classes:message
Subject: Re: Would I be violating the GPL?
Date: Tue, 1 Nov 2005 16:06:27 -0500
Message-ID: <Pine.LNX.4.61.0511011604020.2825@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Would I be violating the GPL?
Thread-Index: AcXfKB/ggpNrgNBbTnC68nwdkmUj6Q==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: <alex@alexfisher.me.uk>
Cc: "Michael Buesch" <mbuesch@freenet.de>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Nov 2005, Alexander Fisher wrote:

> On 11/1/05, Michael Buesch <mbuesch@freenet.de> wrote:
>> On Tuesday 01 November 2005 18:44, you wrote:
>>> No, don't take the code without the suppliers permission.
>>
>> I interpreted his text as if he already has permission to use the code.
>>
>>> It contains
>>> trade secrets and you can get into a ot of trouble if there's an
>>> agreement between the two of you.  Contact the supplier.  Tell them to
>>> abstract away thre kernel headers, or rewrite to remove them, or grant
>>> you persmission to open source the driver.
>>
>> I did not say he should open source the driver. That will give trouble.
>> I suggested to write a _device_ specification. Driver specific things do not
>> care.
>
> I've got the source code to the device firmware too.  So despite the
> fact the driver has been written in c++, it might be possible to write
                                   ^^^^^^^^_________

So you must have some user-mode code (which may not have to be GPL)
plus something that gets installed in the kernel??? Certainly you
don't have a working kernel driver written in C++, do you???


> a usable specification.  This isn't something I want to do.  I'd
> imagine this sort of action can really ruin a supplier/customer
> relationship.  What good is a GPLed driver if no one is prepared to
> sell you the hardware?
> So if the conclusion is that the driver can't be distributed under
> anything other than the GPL (further opinions/confirmations welcome),
> I think I've got two options.  Find a different hardware vendor or
> convince the current supplier to relicense their code.
> I'm hoping that the opinions from one or two major linux kernel
> copyright holders will help me in convincing them to do this.
>
> Thanks,
> Alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
