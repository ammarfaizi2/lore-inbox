Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261882AbRE2A3y>; Mon, 28 May 2001 20:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbRE2A3o>; Mon, 28 May 2001 20:29:44 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:11018 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261882AbRE2A3e>;
	Mon, 28 May 2001 20:29:34 -0400
Message-Id: <200105280117.f4S1HCPS014386@sleipnir.valparaiso.cl>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, arjanv@redhat.com
Subject: Re: [patch] softirq-2.4.5-A1 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Sun, 27 May 2001 22:05:36 +0200." <20010527220536.B731@athlon.random> 
Date: Sun, 27 May 2001 21:17:12 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Deleted Linus from Cc:]
Andrea Arcangeli <andrea@suse.de> said:

[...]

> The only case ksoftirqd runs is when the stock kernel does the wrong
> thing and potentially delays the softirq of 1/HZ. Nothing else.

Thet get the kernel to do the right thing, don't paper over it.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
