Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313755AbSDIG4C>; Tue, 9 Apr 2002 02:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313757AbSDIG4B>; Tue, 9 Apr 2002 02:56:01 -0400
Received: from [151.200.199.53] ([151.200.199.53]:15364 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S313755AbSDIG4A>;
	Tue, 9 Apr 2002 02:56:00 -0400
Message-id: <fc.00858412003ab7af00858412003ab7af.3ab7c7@Capaccess.org>
Date: Tue, 09 Apr 2002 02:55:28 -0400
Subject: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, 4 Apr 2002, Andrea Arcangeli wrote:
>
>> I don't really worry about that, important things will defend by
>> themself, beacuse the GPL solution will be always superior of an
>order
>> of magnitude. [...]
>
>
>how do you do that if the GPL is not being honored? What if in 5 years
>most of the distros ship heaps of binary-only drivers, filesystems,
>storage solutions, and you'll need them just to be able to operate
>your daily system. What if you cannot do certain changes to the kernel
>because your system will not boot up without a certain binary-only
>module.

There are hundreds of distros, thanks in large part to the GPL. I
deliberately skirt the GPL as much as possible in cLIeNUX, but I don't
lose sight of what makes that possible. The major distros think they
are the Libc-of-the-Month Club. Thier grasp of the importance of the
GPL, and unix tradition long predating the GPL, is proportional to the
value of that fine service. See also: "Start button".

>sure, today it's easy to say "i'm not using any 'stinkin binary-only
>module". But tomorrow you might have no choice, because vendors will
>just use binary-only modules to "support Linux". And while 'no module
>at all' used to result in a GPL driver being developed quickly, are
>you sure people will write a GPL replacement if there's a binary-only
>module available? Even if there are such people, who will test the
>driver if the binary-only driver is just 'good enough' for the
>majority of users? The wide availability of binary-only modules was
>not an issue until now, so we (well, a subset of the copyright
>holders) allowed it to a certain extent.

Which was foolish.

<snip>
>
>        Ingo
>

You've seen the IBM Linux ads? With real multi-multi-millionaire
basketball players glaring at the new kid that plays in thier league,
the NBA, the most elite sports league in the world, for free? Those
are some intense glares, from some of the most intense people in the
world. IBM probably paid more for the ballplayers in that ad than Red
Hat grosses.

Imagine you have the basketball gifts of a Shaquille O'Neil AND Alan
Iverson, and you were born stinking rich, like Bill Gates was for
example. You decide to play in the NBA for free. Ain't you cool, eh?
You think the guys in that ad will like it? You think they'll reserve
their cleanest most genteel playing style for your precious ass? An
Alan Iverson is an economic godsend to his entire home city, much less
the one he plays in. You are a threat to his community. The Iverson
rec center where kids stay off drugs, for example. Most NBA players
are from communities where threats get dealt with promptly.

How did they get all those astoundingly authentic glares out of a
bunch of non-actor jocks? Easy. "OK gentlemen, you're looking at the
new kid. He's 7' tall, hits 40% from 3-point land, and PLAYS in the
NBA FOR FREE."

I don't recall seeing a player in those ads named "Dos". Or
"wintendo", or "WinDoS". Maybe there was an "NT", but no matter. IBM
ads are consistantly, clearly about ___servers___ lately. This is
wonderful. They have figured out which word is out of place in the set

        machines
        international
        personal
        business

WinDoS is not even on the court in those ads, that I recall. They're
not in that league, whether I missed them in the ad or not. They don't
play clean enough, for one thing. Not to mention they are a
club-footed midget that can't dribble. But that could change if the
league gets degraded. Wanna see the NBA turn into the NHL, with you as
the double-prime target? I don't even want to watch. I'm already tired
of watching SMP whip Linux's ass.

Leave the server orientation to dinosaurs like Sun, George Gervin,
IBM, Detlef Schrempf... They have the energy, huge resources and
inclination to overcome stupid boring stuff like SMP, an 80-game
season, journalling, New York airports, asm(""), the Hack-a-Shaq ...

It's a simple off-by-one error. Right price, wrong league. The
client-server array is indexed from 0; technically, socially and
economically. "Yeah, but unix is a server OS." Uh, this is 2002.

Rick Hohensee
client-oriented Linux for years now, as exemplified by the following

:; cLIeNUX /dev/tty4  00:49:12   /
:;d -d */
Ha3sm/       command/     device/      help/        owner/       suite/
Linux/       configure/   floppy/      log/         source/      temp/
boot/        dev/         guest/       mount/       subroutine/
:; cLIeNUX /dev/tty4  00:49:16   /
:;

