Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281695AbRK0RMN>; Tue, 27 Nov 2001 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281735AbRK0RME>; Tue, 27 Nov 2001 12:12:04 -0500
Received: from Expansa.sns.it ([192.167.206.189]:21775 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S281695AbRK0RLs>;
	Tue, 27 Nov 2001 12:11:48 -0500
Date: Tue, 27 Nov 2001 18:11:35 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: bart <bart@istnet.net.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: "spurious 8259A interrupt: IRQ7"
In-Reply-To: <1006880612.3708.0.camel@fathom.bajor.dyndns.org>
Message-ID: <Pine.LNX.4.33.0111271808050.14537-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think a couple of months ago I was discussing on this mail list the same
problem with ac. From then I saw this message with every kernel on any VIA
based MB i tryed (for athlon, for K6 and so on). It is harmless, but
noisy. of course, disabling IOAPIC the problem does always disappear, but
it's again noisy.

On 28 Nov 2001, bart wrote:

> Hi,
>
> Iv seen this on a Intel BX chipset Pentium2 266 box, and on a VIA KT266A
> 1ghz Athlon box.
>
> BaRT
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


