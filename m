Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269802AbRHSBTw>; Sat, 18 Aug 2001 21:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269811AbRHSBTn>; Sat, 18 Aug 2001 21:19:43 -0400
Received: from Expansa.sns.it ([192.167.206.189]:50182 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S269802AbRHSBTY>;
	Sat, 18 Aug 2001 21:19:24 -0400
Date: Sun, 19 Aug 2001 03:19:33 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: disk I/O slower with kernel 2.4.9 
In-Reply-To: <Pine.LNX.4.33L.0108182140350.5646-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108190319080.2859-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still have to try it, tomorrow i will post the results....


On Sat, 18 Aug 2001, Rik van Riel wrote:

> On Sun, 19 Aug 2001, Luigi Genoni wrote:
>
> > just making time make -j 2 bzImage with kernel source 2.4.9
> > gives me:
> >
> > real    3m36.041s
> > user    2m2.950s
> > sys     0m9.740s
> >
> > while compiling the same sources running kernel 2.4.7 gives:
> >
> > real    2m28.350s
> > user    1m56.150s
> > sys     0m5.262s
>
> How does 2.4.8-ac7 do ?
>
> Rik
> --
> IA64: a worthy successor to i860.
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

