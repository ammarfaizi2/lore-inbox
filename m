Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276234AbRJCN3S>; Wed, 3 Oct 2001 09:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276247AbRJCN3K>; Wed, 3 Oct 2001 09:29:10 -0400
Received: from [200.248.92.2] ([200.248.92.2]:34823 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S276234AbRJCN24>; Wed, 3 Oct 2001 09:28:56 -0400
Message-Id: <200110031331.KAA26718@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: <cwright@softpixel.com>, linux-kernel@vger.kernel.org
Subject: Re: kswapd kernel 2.4.9
Date: Wed, 3 Oct 2001 10:27:19 -0300
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <30402.205.188.199.21.1002115377@webmail.softpixel.com>
In-Reply-To: <30402.205.188.199.21.1002115377@webmail.softpixel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua 03 Out 2001 10:22, cwright@softpixel.com escreveu:
> > I\'m running kernel 2.4.9 under a DELL 8450 with 8xP-III  and 10GB RAM.
> > Yesterday a run a BIG   I/O, and when this process run, my cached goes to
>
> 9GB
>
> > and the kswapd is using 100% of one cpu after that.
>
> did it stay at 100%, or did it ease up slightly afterward?
>
> I have noticed a similar problem with ancient kernels (2.0.0) and not quite
> as ancient one (2.2.19) where certain applications cause all your physical
> ram to be used, then all the cache.  after its all used (for some mystery
> purpose?) it goes back to normal.  maybe my boxes are just flukes though
>
>         chris
>
I don't reboot the machine and the kswapd stay 100% all the time


Andre
