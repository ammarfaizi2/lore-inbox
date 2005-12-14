Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVLNVgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVLNVgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVLNVgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:36:41 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:43408 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932335AbVLNVgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:36:40 -0500
Message-ID: <027e01c600f5$d1952d80$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <024501c600f2$24e8ccc0$0400a8c0@dcccs> <1134594964.9442.10.camel@laptopd505.fenrus.org>
Subject: Re: irq balancing question
Date: Wed, 14 Dec 2005 22:31:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

----- Original Message ----- 
From: "Arjan van de Ven" <arjan@infradead.org>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 14, 2005 10:16 PM
Subject: Re: irq balancing question


> On Wed, 2005-12-14 at 22:05 +0100, JaniD++ wrote:
> > Hello, list,
> >
> > I try to tune my system with manually irq assigning, but this simple not
> > works, and i don't know why. :(
> > I have already read all the documentation in the kernel tree, and search
in
> > google, but i can not find any valuable reason.
>
>
> which chipset? there is a chipset that is broken wrt irq balancing so
> the kernel refuses to do it there...

This happens all of my systems, with different hardware.

In the example is Intel SE7520AF2,  IntelR E7520 Chipset, +2x Xeon with HT.

And the other systems is Abit IS7, intel 865, and only one P4 CPU with HT,
but the issue is the same.

Cheers,
Janos


>

