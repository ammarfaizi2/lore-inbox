Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264217AbTCXOUq>; Mon, 24 Mar 2003 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264218AbTCXOUq>; Mon, 24 Mar 2003 09:20:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:65420 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264217AbTCXOUm>; Mon, 24 Mar 2003 09:20:42 -0500
Date: Mon, 24 Mar 2003 09:33:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ded-Fat 8.0 and ext3
In-Reply-To: <1048515655.1636.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.53.0303240926001.24323@chaos>
References: <Pine.LNX.4.53.0303211420170.13876@chaos>  <1048324118.3306.3.camel@LNX.iNES.RO>
  <Pine.LNX.4.53.0303240909410.24249@chaos> <1048515655.1636.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003, Arjan van de Ven wrote:

> On Mon, 2003-03-24 at 15:11, Richard B. Johnson wrote:
>
> > I did not bother to go any further than `make oldconfig` and
> > `make dep` in this "Show-and-tell". As previously reported,
>
> as previously report to YOU: you have to do a make mrproper first.
> Then it just works.
>

Look at the damn script. It does every possible:
make clean
make distclean
make mrproper  (line 71)

It's hard to find because script got broken in that distribution,
too.

Again look at the evidence, rather than just barking back a
retort.

> I've not received a SINGLE report where starting with make mrproper
> didn't fix this issue. You can claim I ignore this issue, but I don't.
> It's just not an issue at all so far!
>
Well you got more than a "SINGLE" report now. Please check it out.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

