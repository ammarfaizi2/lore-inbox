Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTBOQHX>; Sat, 15 Feb 2003 11:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTBOQHX>; Sat, 15 Feb 2003 11:07:23 -0500
Received: from [195.223.140.107] ([195.223.140.107]:3200 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262789AbTBOQHW>;
	Sat, 15 Feb 2003 11:07:22 -0500
Date: Sat, 15 Feb 2003 17:18:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: openbkweb-0.0
Message-ID: <20030215161821.GC29194@dualathlon.random>
References: <20030214203151.GL20159@fs.tum.de> <Pine.LNX.4.44.0302141553320.1097-100000@localhost.localdomain> <20030215003951.GB4333@bjl1.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215003951.GB4333@bjl1.jlokier.co.uk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 12:39:51AM +0000, Jamie Lokier wrote:
> Imagine if all your friends started talking a different language,
> called Binglish say.  You'd want to talk to them in that language so
> you could socialise and work with them.  Now if they told you you must
> sign a contract and join a private society, or pay significant cash,
> otherwise you couldn't talk the language?  If it were a few people
> you'd ignore them, but if it seemed like all the really powerful
> people who affect your life would just ignore you unless you talked
> it, you'd be pissed off.  You'd feel the playing field had become
> unlevel and needed correction.  You'd be tempted to either (1) cave in
> and pay or join the private society, (2) learn the language and
> use it anyway.

nice comparison.

However my short term concern is not to speak Binglish but just to
translate from Binglish to English. We need access to the data with an
open protocol and to backup the data in a open format. so we can use it
too. And Larry is now going to provide the data in the open, IMHO only
if that didn't happen we had to research into the possibility of legally
reverse enegeneering the bitkeeper protocol. the fact he is now
providing the data out in the open avoids us to waste time.

After we can reach the data we can use any version control system we
want to manage it, I'm going to write MORE STUPID scripts to do that.
I'm been told of several giga archives with dozen thousand revisions
under subversion for istance (I know Al Viro blamed subversion code but
if the design it's good it may be a good start).  subversion may not
have all the features of bitkeeper but we can certainly add them over
time, the only thing it matters to me is that we get rid of being forced
to use a proprietary protocol to fetch the data.

The kernel CVS in more than enough for my/our needs and I thank Larry
for seeing it was necessary to allow the kernel data to be open. Now
there's no reason to argue anymore with Larry or Linus, they can choose
what they can legally use and we can choose what we can legally use and
what we find more productive in the long run. I really believe in open
protocols and open source software being superior and a necessary thing
in the long run, it's not that I advocate people to use open source
products and then I change my mind and I run proprietary apps to develop
the kernel (I don't put a smile here because clearly this isn't an
obvious thought).

Andrea
