Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274250AbRISXI7>; Wed, 19 Sep 2001 19:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272889AbRISXIu>; Wed, 19 Sep 2001 19:08:50 -0400
Received: from Expansa.sns.it ([192.167.206.189]:12804 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S274256AbRISXIj>;
	Wed, 19 Sep 2001 19:08:39 -0400
Date: Thu, 20 Sep 2001 01:08:54 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Gergely Tamas <dice@mfa.kfki.hu>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Liakakis Kostas <kostas@skiathos.physics.auth.gr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.33.0109191711580.3210-100000@falka.mfa.kfki.hu>
Message-ID: <Pine.LNX.4.33.0109200108140.25500-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3R was not working for me too, 3C is well working, actually.

Luigi
On Wed, 19 Sep 2001, Gergely Tamas wrote:

> Hi!
>
>  > If your answer is <=256MB, one module, no surprise then, as AFAIK nobody
>  > with such config suffers from the problem. But checking also number of
>  > memory modules looks more like black magic that anything else.
>  > Hopefully VIA will answer...
>
> Not exactly. I can report about two different machines - my home one, and
> one here at workplace - which hit this bug. Linux even does not start on
> them with 3R. Both of them have got 256 Mb, one module. This fix helps for
> both of them.
>
> Gergely
>
> ps: ABIT KT7A, Duron 750MHz, 256Mb (one module)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

