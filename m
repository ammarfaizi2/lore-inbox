Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290229AbSA3RX4>; Wed, 30 Jan 2002 12:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290235AbSA3RWL>; Wed, 30 Jan 2002 12:22:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60168 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290224AbSA3RVz>; Wed, 30 Jan 2002 12:21:55 -0500
Date: Wed, 30 Jan 2002 09:20:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VrdT-0006t7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201300917270.1928-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Alan Cox wrote:
>
> So if someone you trusted actually started batching up small fixes and
> sending you things like
>
> "37 random documentation updates - no code changed", "11 patches to fix
> kmalloc checks", "maintainers updates to 6 network drivers"
>
> that would work sanely ?

Yes. That would take a whole lot of load off me - load I currently handle
by just not sweating the small stuff, and concentrating on the things I
think are important.

> The other related question is device driver implementation stuff (not interfaces
> and abstractions). You don't seem to check that much anyway, or have any taste
> in device drivers 8) so should that be part of the small fixing job ?

I think it has some of the same issues, but I really would prefer to have
it in a separate batch.

Quite frankly, this is a large part of what you did..

		Linus

