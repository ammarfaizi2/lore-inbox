Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279036AbRJVWrU>; Mon, 22 Oct 2001 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279035AbRJVWrQ>; Mon, 22 Oct 2001 18:47:16 -0400
Received: from deepthought.blinkenlights.nl ([62.58.162.228]:4868 "EHLO
	mail.blinkenlights.nl") by vger.kernel.org with ESMTP
	id <S279034AbRJVWpe>; Mon, 22 Oct 2001 18:45:34 -0400
Date: Tue, 23 Oct 2001 01:00:54 +0200 (CEST)
From: Sten <sten@blinkenlights.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
In-Reply-To: <20011022.153947.48529984.davem@redhat.com>
Message-ID: <Pine.LNX.4.40-blink.0110230056450.20416-100000@deepthought.blinkenlights.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, David S. Miller wrote:

>    From: Sten <sten@blinkenlights.nl>
>    Date: Tue, 23 Oct 2001 00:50:42 +0200 (CEST)
>
>    Well the thing is that I like todo evil things,
>    like connecting sgi flatpanels to creator3d's, using
>    non sun blessed ( aka sub 1000$ ) ethernet cards or
>    sticking in wierd raid cards.
>
>    Which is why I like linux ;)
>
>    Having source is great because I can break it,
>    and maybe learn something in the process.
>
> All of this is irrelevant to going over the 3.5MB mark,
> I contend that your machine simply does not need it no matter
> what obscure stuff you stick into it :-)

I wonder if pci to isa adaptors exist ;)

> Turn off the PCI device names, that is usually what eats up a
> lot of space and lspci provides the same info anyways...

jup, that's what I came up with as well.

Off to bed now, many more boxen to upgrade tomorrow,
gotta love ptrace. Especially when they annouce the hole
on friday 16:30 just when you prepare for going home.

--

Sten Spans

