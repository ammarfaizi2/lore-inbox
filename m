Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVLOAx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVLOAx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVLOAx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:53:26 -0500
Received: from fmr21.intel.com ([143.183.121.13]:16835 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S965095AbVLOAxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:53:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: irq balancing question
Date: Wed, 14 Dec 2005 16:48:15 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006A222B5@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: irq balancing question
Thread-Index: AcYA9qTBrUZ54X51RvCUqW6cHRrs3AAGnz3A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "JaniD++" <djani22@dynamicweb.hu>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Dec 2005 00:48:16.0288 (UTC) FILETIME=[3C35FA00:01C60111]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of JaniD++
>Sent: Wednesday, December 14, 2005 1:32 PM
>To: Arjan van de Ven
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: irq balancing question
>
>Hi,
>
>----- Original Message ----- 
>From: "Arjan van de Ven" <arjan@infradead.org>
>To: "JaniD++" <djani22@dynamicweb.hu>
>Cc: <linux-kernel@vger.kernel.org>
>Sent: Wednesday, December 14, 2005 10:16 PM
>Subject: Re: irq balancing question
>
>
>> On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
>> > Hello, list,
>> >
>> > I try to tune my system with manually irq assigning, but 
>this simple not
>> > works, and i don't know why. :(
>> > I have already read all the documentation in the kernel 
>tree, and search
>in
>> > google, but i can not find any valuable reason.
>>
>>
>> which chipset? there is a chipset that is broken wrt irq balancing so
>> the kernel refuses to do it there...
>
>This happens all of my systems, with different hardware.
>
>In the example is Intel SE7520AF2,  IntelR E7520 Chipset, +2x 
>Xeon with HT.
>
>And the other systems is Abit IS7, intel 865, and only one P4 
>CPU with HT,
>but the issue is the same.
>

Which kernel and which architecture (i386 or x86-64?)

Thanks,
Venki
