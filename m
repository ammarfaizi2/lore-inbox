Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSKESh2>; Tue, 5 Nov 2002 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265144AbSKESh2>; Tue, 5 Nov 2002 13:37:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265123AbSKESh1>; Tue, 5 Nov 2002 13:37:27 -0500
Date: Tue, 5 Nov 2002 10:43:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <marcelo@conectiva.com.br>
Subject: Re: PATCH: Driver Maintainers
In-Reply-To: <E1898LP-0003Ie-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0211051035390.2777-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Nov 2002, Alan Cox wrote:
> 
> One thing the FSF do which is rather sensible is keep a list in the packages
> of people who you can pay to fix stuff in them. I asked on Linux-kernel
> and got a small initial set of company responses. hopefully more will appear
> once its merged.

I would really prefer for there to be some kind of explicit requirements
for this. Even if we don't endorse the thing, I'd hate to have a bad egg
or two (assuming this expands a lot, which I think it might) causing 
trouble.

I'd also like for it to be explicitly only for individuals or small
companies ( "less than x people" ), or some other way make sure that the
thing is balanced and we set peoples expectations right (both users of the
list as well as people who want to be on the list).

Also, is the kernel source really the right place for this, considering
that many people will have sources that are years old and there is no way 
to remove potential problematic entries from already-released kernels? In 
other words, wouldn't it be better to have some nice place on the web and 
a pointer to that in the kernel sources?

		Linus

