Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRHSAl3>; Sat, 18 Aug 2001 20:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269775AbRHSAlT>; Sat, 18 Aug 2001 20:41:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39691 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269739AbRHSAlF>;
	Sat, 18 Aug 2001 20:41:05 -0400
Date: Sat, 18 Aug 2001 21:40:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: disk I/O slower with kernel 2.4.9 
In-Reply-To: <Pine.LNX.4.33.0108190037070.1823-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33L.0108182140350.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Luigi Genoni wrote:

> just making time make -j 2 bzImage with kernel source 2.4.9
> gives me:
>
> real    3m36.041s
> user    2m2.950s
> sys     0m9.740s
>
> while compiling the same sources running kernel 2.4.7 gives:
>
> real    2m28.350s
> user    1m56.150s
> sys     0m5.262s

How does 2.4.8-ac7 do ?

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

