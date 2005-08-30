Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVH3M2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVH3M2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 08:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVH3M2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 08:28:25 -0400
Received: from spirit.analogic.com ([208.224.221.4]:2060 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751419AbVH3M2Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 08:28:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9a87484905083005064cf4e6d0@mail.gmail.com>
References: <200508292303.52735.chase.venters@clientec.com> <9a87484905083005064cf4e6d0@mail.gmail.com>
X-OriginalArrivalTime: 30 Aug 2005 12:28:23.0768 (UTC) FILETIME=[506B7D80:01C5AD5E]
Content-class: urn:content-classes:message
Subject: Re: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Date: Tue, 30 Aug 2005 08:27:27 -0400
Message-ID: <Pine.LNX.4.61.0508300818420.4191@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Thread-Index: AcWtXlCUOzT3+yo0TP29PYPKfj1zUQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Chase Venters" <chase.venters@clientec.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Aug 2005, Jesper Juhl wrote:

> On 8/30/05, Chase Venters <chase.venters@clientec.com> wrote:
>> Greetings kind hackers...
>>         I recently switched to 2.6.13 on my desktop. I noticed that the second
>> "CPU" (is there a better term to use in this HyperThreading scenario?) that
>> used to be listed in /proc/cpuinfo is no longer present. Browsing over the
> [snip]
>
> CONFIG_MPENTIUM4, CONFIG_SMP and CONFIG_SCHED_SMT enabled?
>

I have the same problem since linux-2.6.x  Linux-2.4.20 and on
had no problem with Hyper-Threading. My startup says:

CPU: Hyper-Threading is disabled.  There is no enable/disable
in the BIOS so I don't know what to do. It's an Intel D865PERL
Motherboard so certainly Intel should know how to enable their CPUs.

> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
