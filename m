Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTBOVWK>; Sat, 15 Feb 2003 16:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTBOVWK>; Sat, 15 Feb 2003 16:22:10 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:32404 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265168AbTBOVWJ>; Sat, 15 Feb 2003 16:22:09 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 15 Feb 2003 13:31:16 -0800 (PST)
Subject: Re: openbkweb-0.0
In-Reply-To: <20030215161821.GC29194@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0302151329590.656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea, since the on-disk format for bitkeeper is supposed to be SCCS
would it be good enough for you to be able to get a copy of this? what
mechanism would you prefer to use to get updates (rsync, FTP, HTTP, etc)

David Lang

On Sat, 15 Feb 2003, Andrea Arcangeli wrote:

> Date: Sat, 15 Feb 2003 17:18:21 +0100
> From: Andrea Arcangeli <andrea@suse.de>
> To: Jamie Lokier <jamie@shareable.org>
> Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
>      Alan Cox <alan@lxorguk.ukuu.org.uk>
> Subject: Re: openbkweb-0.0
>
> On Sat, Feb 15, 2003 at 12:39:51AM +0000, Jamie Lokier wrote:
> > Imagine if all your friends started talking a different language,
> > called Binglish say.  You'd want to talk to them in that language so
> > you could socialise and work with them.  Now if they told you you must
> > sign a contract and join a private society, or pay significant cash,
> > otherwise you couldn't talk the language?  If it were a few people
> > you'd ignore them, but if it seemed like all the really powerful
> > people who affect your life would just ignore you unless you talked
> > it, you'd be pissed off.  You'd feel the playing field had become
> > unlevel and needed correction.  You'd be tempted to either (1) cave in
> > and pay or join the private society, (2) learn the language and
> > use it anyway.
>
> nice comparison.
>
> However my short term concern is not to speak Binglish but just to
> translate from Binglish to English. We need access to the data with an
> open protocol and to backup the data in a open format. so we can use it
> too. And Larry is now going to provide the data in the open, IMHO only
> if that didn't happen we had to research into the possibility of legally
> reverse enegeneering the bitkeeper protocol. the fact he is now
> providing the data out in the open avoids us to waste time.
>
> After we can reach the data we can use any version control system we
> want to manage it, I'm going to write MORE STUPID scripts to do that.
> I'm been told of several giga archives with dozen thousand revisions
> under subversion for istance (I know Al Viro blamed subversion code but
> if the design it's good it may be a good start).  subversion may not
> have all the features of bitkeeper but we can certainly add them over
> time, the only thing it matters to me is that we get rid of being forced
> to use a proprietary protocol to fetch the data.
>
> The kernel CVS in more than enough for my/our needs and I thank Larry
> for seeing it was necessary to allow the kernel data to be open. Now
> there's no reason to argue anymore with Larry or Linus, they can choose
> what they can legally use and we can choose what we can legally use and
> what we find more productive in the long run. I really believe in open
> protocols and open source software being superior and a necessary thing
> in the long run, it's not that I advocate people to use open source
> products and then I change my mind and I run proprietary apps to develop
> the kernel (I don't put a smile here because clearly this isn't an
> obvious thought).
>
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
