Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285132AbRLRUhx>; Tue, 18 Dec 2001 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285094AbRLRUhj>; Tue, 18 Dec 2001 15:37:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62867 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285138AbRLRUfD>;
	Tue, 18 Dec 2001 15:35:03 -0500
Date: Tue, 18 Dec 2001 23:32:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: in defense of the linux-kernel mailing list
In-Reply-To: <Pine.LNX.4.33L.0112181712530.28489-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112182229450.10550-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Rik van Riel wrote:

> > And no, I don't think IRC counts either, sorry.
>
> Whether you think it counts or not, IRC is where most stuff is
> happening nowadays.

most of the useful traffic on lkml cannot be expressed well on IRC. While
IRC might be useful as an additional form of communication channel, email
lists IMO should still be the main driving force of Linux kernel
development, else we'll only concentrate on those minute ideas that can be
expressed in 1-2 lines on irc and which are simple enough to be understood
until the next message comes. Also, the lack of reliable archiving of IRC
traffic prevents newcomers of reproducing the thought process afterwards.
While IRC might result in the seasoned kernel developer doing the next
super-patch quickly, it will in the end effect only isolate and alienate
newcomers and will only result in an aging, personality-driven elitist
old-boys network and a dying OS.

Regarding the use of IRC as the main development medium for the Linux
kernel - the fast pace of IRC often prevents deeper thoughts - while this
is definitely the point for many people who use IRC, it cannot result in a
much better kernel. [that having said, i'm using irc on a daily basis as
well so this is not irc-bashing, but i rarely use it for development
purposes.]

It's true that reading off-topic emails on lkml isnt a wise use of
developer powers either, but this has to be taken into account just like
spam - it's the price of having an open forum.

and honestly, much of the complaints about lkml's quality are exagerated.
What you dont take into account is the fact that while 3 or 5 years ago
you found perhaps every email on lkml exciting and challenging, today you
are an experienced kernel hacker and find perhaps 90% of the traffic
'boring'. I've just done a test - and perhaps i picked the wrong set of
emails - but the majority of lkml traffic is pretty legitimate, and i
would have found most of them 'interesting and exciting' just 5 years ago.
Today i know what they mean and might find them less challenging to
understand - but that is one of the bad side-effects of experience.
Today there are more people on lkml, more bugs get reported, and more
patches are discussed - so keeping up with lkml traffic is harder. Perhaps
it might make sense to separate linux-kernel into two lists:
linux-kernel-bugs and linux-kernel-devel (without moderation), but
otherwise the current form and quality of discussions (knock on wood) is
pretty OK i think.

also, more formal emails match actual source code format better than the
informal IRC traffic. So by being kindof forced to structure information
into a larger set of ASCII text, it will also be the first step towards
good kernel code.

(on IRC one might be the super-hacker with a well-known nick, entering and
exiting channels, being talked to by newbies. It might boost one's ego.
But it should not cloud one's judgement.)

	Ingo

