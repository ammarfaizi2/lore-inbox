Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHFWsy>; Mon, 6 Aug 2001 18:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269102AbRHFWso>; Mon, 6 Aug 2001 18:48:44 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:41404 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S269099AbRHFWsd>;
	Mon, 6 Aug 2001 18:48:33 -0400
Date: Tue, 7 Aug 2001 00:48:37 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.LNX.4.21.0108031920410.8951-100000@freak.distro.conectiva>
Message-ID: <Pine.A41.4.31.0108070044550.37910-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Marcelo Tosatti wrote:

> Does the problem happen only with the used-once patch ?
>
> If it also happens without the used-once patch, can you reproduce the
> problem with 2.4.6 ?
The problem happened about 4 times, with the used-once patch,
but I don't know exactly what triggered it.

now I use 2.4.7-ac5, and I have not seen the problem, yet.

I will try with the used-once patch, if it appears again.

Bye,
Szabi


