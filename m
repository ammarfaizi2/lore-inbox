Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbVLOJPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbVLOJPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbVLOJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:15:09 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:12986 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1161150AbVLOJPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:15:07 -0500
Message-ID: <00aa01c60157$6a54e950$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: <linux-kernel@vger.kernel.org>
References: <88056F38E9E48644A0F562A38C64FB6006A222B5@scsmsx403.amr.corp.intel.com>
Subject: Re: irq balancing question
Date: Thu, 15 Dec 2005 10:10:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "JaniD++" <djani22@dynamicweb.hu>; "Arjan van de Ven"
<arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, December 15, 2005 1:48 AM
Subject: RE: irq balancing question


>
>
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of JaniD++
> >Sent: Wednesday, December 14, 2005 1:32 PM
> >To: Arjan van de Ven
> >Cc: linux-kernel@vger.kernel.org
> >Subject: Re: irq balancing question
> >
> >Hi,
> >
> >----- Original Message ----- 
> >From: "Arjan van de Ven" <arjan@infradead.org>
> >To: "JaniD++" <djani22@dynamicweb.hu>
> >Cc: <linux-kernel@vger.kernel.org>
> >Sent: Wednesday, December 14, 2005 10:16 PM
> >Subject: Re: irq balancing question
> >
> >
> >> On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
> >> > Hello, list,
> >> >
> >> > I try to tune my system with manually irq assigning, but
> >this simple not
> >> > works, and i don't know why. :(
> >> > I have already read all the documentation in the kernel
> >tree, and search
> >in
> >> > google, but i can not find any valuable reason.
> >>
> >>
> >> which chipset? there is a chipset that is broken wrt irq balancing so
> >> the kernel refuses to do it there...
> >
> >This happens all of my systems, with different hardware.
> >
> >In the example is Intel SE7520AF2,  IntelR E7520 Chipset, +2x
> >Xeon with HT.
> >
> >And the other systems is Abit IS7, intel 865, and only one P4
> >CPU with HT,
> >but the issue is the same.
> >
>
> Which kernel and which architecture (i386 or x86-64?)

i386, and kernel 2.6.14 - 2.6.15-rc3

(the intel xeon CPU can work x86-64 kernels?)

Cheers,
Janos

>
> Thanks,
> Venki
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

