Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130454AbQLKUwE>; Mon, 11 Dec 2000 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130671AbQLKUvz>; Mon, 11 Dec 2000 15:51:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39887 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130454AbQLKUvo>;
	Mon, 11 Dec 2000 15:51:44 -0500
Date: Mon, 11 Dec 2000 15:21:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dietmar Kling <dietmar.kling@sam-net.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <3A352443.E3FEE114@sam-net.de>
Message-ID: <Pine.GSO.4.21.0012111519250.9674-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, Dietmar Kling wrote:

> > You do realize what "evolution" means? I'm not talking about the bugs
> > in implementation. I'm talking about botched design. _That_ never gets
> > fixed. Show me one example when that would happen and I might consider
> > taking such possibility seriously.
> 
> That's what I am talking about in my "mean" attitude. Some things
> must be  carried until the dead end. When there's no place to move
> anymore than new things will evolve.

Minix is still alive.

> < short thinking >
> As for your second point. Take libc5 and libc6. I really have no
> *deep* insight. But I believe redesigning it for Multithreading
> was mayor step.

... and libc6 was not a result of evolution of libc5 - they have a
common ancestor, but they got several years of divergent evolution
before the displacement had happened.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
