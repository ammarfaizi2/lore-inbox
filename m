Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129844AbQLKTYX>; Mon, 11 Dec 2000 14:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQLKTYN>; Mon, 11 Dec 2000 14:24:13 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37042 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129866AbQLKTYD>;
	Mon, 11 Dec 2000 14:24:03 -0500
Date: Mon, 11 Dec 2000 13:53:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dietmar Kling <dietmar.kling@sam-net.de>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <3A3513F2.DF0F5289@sam-net.de>
Message-ID: <Pine.GSO.4.21.0012111306150.7433-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, Dietmar Kling wrote:

> I do not understand this 
> "i saw it - yuck! - and now i want to kill it "

s/want to kill it/do not want to touch it/

> point of view.
> As I tried to point out. Things evolve. And
> the evolution has the right do things wrong.
> Next evolution step will do it probably better.

You do realize what "evolution" means? I'm not talking about the bugs
in implementation. I'm talking about botched design. _That_ never gets
fixed. Show me one example when that would happen and I might consider
taking such possibility seriously.

> Al same as kernel development.  With your attitude
> i'd have dropped linux 0.99 immediatly.
> Remember the code in certain parts?

And? It wasn't nearly that huge and what matters _much_ more it was not
that tasteless.

> So what is your point?
> I accept only  shiny little masterpieces of software?

No. The larger it is - the harder it is to redesign. And both GNOME and
KDE are _way_ past the size*severity_of_misdesign threshold. IOW, I simply
don't believe that either project has sufficient manpower to fix their stuff.
And that's orders of magnitude insufficient. As far as I can see they are
also way past "it's easier to do from scratch than to fix" threshold. The
same reason why I don't believe that NT will ever become decent OS, even
if the full source would become available, yodda, yodda.

Feel free to prove me wrong, but I would be very surprised to see it. And
yes, the fact that UNIX was conceptually simple and relatively small helped
it _big_ way. Small beasts adapt and propagate. Huge ones tend to become
dead-ends. So much for evolution...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
