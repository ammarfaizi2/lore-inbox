Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269212AbRHBW40>; Thu, 2 Aug 2001 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269213AbRHBW4G>; Thu, 2 Aug 2001 18:56:06 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:39558 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S269212AbRHBW4F>;
	Thu, 2 Aug 2001 18:56:05 -0400
Date: Fri, 3 Aug 2001 00:56:08 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108021925460.5582-100000@duckman.distro.conectiva>
Message-ID: <Pine.A41.4.31.0108030047360.43610-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Rik van Riel wrote:

> On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
>
> > I'm telling you that's not what happens.  When memory pressure
> > gets really high, the kernel takes all the CPU time and the box
> > is completely useless. Maybe the VM sorts itself out but after
> > five minutes of barely responding, I usually just power cycle
> > the damn thing.  As I said, this isn't a classic thrash because
> > the swap disks only blip perhaps once every ten seconds!

this is exactly what's happening here. (as I wrote in the 'kswapd eats the
cpu without swap' mail)

the network work's here too, but I can't do anything. I can't even switch
between VT-s
but it's really hard to reproduce.

Bye,
Szabi



