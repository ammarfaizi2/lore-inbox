Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSEYRXc>; Sat, 25 May 2002 13:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSEYRXb>; Sat, 25 May 2002 13:23:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293680AbSEYRXb>; Sat, 25 May 2002 13:23:31 -0400
Date: Sat, 25 May 2002 10:22:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Thunder from the hill <thunder@ngforever.de>
cc: Larry McVoy <lm@bitmover.com>, Karim Yaghmour <karim@opersys.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Thunder from the hill wrote:
>
> 2. They get used to RTLinux, where they are altogether forced to use
>    either GPL or their license. This isn't exactly a way of choice.

Ehh. That's just because of fud. Your (2) is _not_ the choice.

Does the RT part have to be GPL? Yes. Big whoopte-do. So does kernel
modules in general, if they are clearly derived works of Linux (which, in
something like this, is pretty obviously the case).

So you split your problem into the RT device driver and the user. And of
story. Stop this stupid FUD.

The thing that disgusts me is that this "patent" thing is used as a
complete red herring, and the real issue is that some people don't like
the fact that the kernel is under the GPL. Tough cookies.

Stop making excuses. I'm personally really happy with having another
reason why people should make all their kernel modules GPL'd. I see way
too many problems with things like the nVidia kernel modules etc, and I
realize that the GPL scares away some people, and I don't care.

Some people (you and Karim) seem to think that the GPL requirement si
going to hurt Linux in the embedded space. Fair enough. That's what all
the BSD people claimed was the case about Linux in server space, Linux on
the desktop, or Linux anywhere.

Personally, I'll just bet on open source myself. Even in the embedded
space. And anybody who bets against me, I just don't care about, because
it has zero impact on me.

		Linus

