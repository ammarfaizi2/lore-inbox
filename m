Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRLTLKf>; Thu, 20 Dec 2001 06:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284153AbRLTLK0>; Thu, 20 Dec 2001 06:10:26 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20638 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284144AbRLTLKL>;
	Thu, 20 Dec 2001 06:10:11 -0500
Date: Thu, 20 Dec 2001 14:07:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: James Cleverdon <jamesclv@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
In-Reply-To: <Pine.LNX.4.33.0112192154190.19321-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112201405550.6212-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, Linus Torvalds wrote:

> > Marcello and Linus, please apply.
>
> Can you give a rough description of what kinds of arrays this will
> impact, just out of curiosity. Ie do we talk about "5kB more memory in
> order to avoid problems", or are we talking about something
> noticeable..
>
> 		Linus "too lazy to grep" Torvalds

the change is OK, it's about +3K RAM used, on SMP kernels.

	Ingo

