Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSEXVrw>; Fri, 24 May 2002 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSEXVrv>; Fri, 24 May 2002 17:47:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35855 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311898AbSEXVrv>; Fri, 24 May 2002 17:47:51 -0400
Date: Fri, 24 May 2002 14:46:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <3CEEAE3D.EB64A3AA@opersys.com>
Message-ID: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Karim Yaghmour wrote:
>
> I've been involved in fighting this patent for the last 2 years. During
> this time, I have met and talked with many people about this issue. Today,
> I can assure you that the rtlinux patent is definitely a show-stopper for
> Linux.

_Why_?

That patent is expressly licensed for GPL'd kernels, ie Linux.

It might be an issue with some other OS, but not Linux.

See "http://www.fsmlabs.com/about/patent/openpatentlicense.htm".

I've heard a lot of discussions about ho this kind of "license to Open
Source software" kinds of patents have long been discussed as ways to
subvert the patent system the same way that the copyleft itself subverts
the copyrights.

Even the FSF supports this particular patent (they used to have some
issues about the patent license being revocable, but now you have the
patent license "as long as the licensee compiles with this license and the
terms of the GPL".

[ Actually, the FSF is slightly unhappy about the fact that that patent
  license expressly picks out GPL v2, the same way the _kernel_ explicitly
  mentions that only v2 of the GPL is the default. Victor, like me, does
  not trust the FSF to remain faithful to its original licenses. ]

In short, it you start playing fast and lose with the GPL, you lose the
patent rights too. Too bad. But if you stay true, that license is yours,
for free. Exactly like the GPL requires.

			Linus

