Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSE2Blp>; Tue, 28 May 2002 21:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSE2Blo>; Tue, 28 May 2002 21:41:44 -0400
Received: from mark.mielke.cc ([216.209.85.42]:62987 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S310206AbSE2Bln>;
	Tue, 28 May 2002 21:41:43 -0400
Date: Tue, 28 May 2002 21:34:57 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, yodaiken@fsmlabs.com,
        linux-kernel@vger.kernel.org
Subject: Re: A reply on the RTLinux discussion.
Message-ID: <20020528213457.A22540@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.21.0205281702540.17583-100000@serv> <1022604318.4123.114.camel@irongate.swansea.linux.org.uk> <3CF42179.29A2CAED@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 02:31:53AM +0200, Roman Zippel wrote:
> Alan Cox wrote:
> > Perhaps you should spend your
> > time thinking instead of insinuating everyone on the planet who isnt
> > working for rtai is a liar ?
> I am watching this whole mess already quite some time and I am trying
> very hard to make sense out of this. Victor pretends to be the nice guy
> here, but if one looks closer, one can see how little respect he has for

I can't speak for Victor, but...

Is it illegal for Victor to keep his options open?

It is really simple. Either A) Victor has a patent, and code in RTAI
may need to be licensed, or B) Victor has a patent, and code in RTAI
does not need to be licensed.

The text for the patent is available. Technical people and lawyers
huddle over a table, decide whether it is worth the risk, and go from
there. This is the way that every company must go under our current
legal structure.

Even if you *did* get a 'straight' answer out of Victor, his words
would not change his ability to sue RTAI. If RTAI needs a license,
they should *get* a license. If they don't need a license, they don't
need a license.

What is clear, is that the wrong question is being asked to the wrong
person. You don't ask Victor whether you can be exempt from potential
risk. You ask Victor for a license (i.e. written down and signed by
his company), or you take the risk, and assume that you do not need a
license. In neither case do you ask "I think my code might infringe on
your patent, can you make a (verbal) statement publicly that you will
look away if indeed you ever, at any time in the future, decide that
it is?"

In fact, if such a question was posed (which I think we have
observed), I would assume that the company posing the question was not
legally responsible, and *I*, as a prospective client in need of a RT
OS for my application, would avoid. The last thing I need is the
company working on my RT OS to be sued and disappear. I would much
prefer to work with the company that has the patent.

But then again - this is the crux of the matter. RTAI is suffering due
to 'patent issues', and RTLinux is not. RTLinux owns the patent, after
all. This couldn't possibly be RTAI whining because they cannot get
a large enough customer base, could it?

Sure there are all sorts of precidences that this sets. However, I have
yet to see any sort of true evolution or development *not* set
precidences.

The only real argument I have seen from RTAI folk is that Victor isn't
being a proper Open Source priest. This may annoy other Open Source
priests, but it does not affect my own opinion of the man. I find the
'Open Source' religion to have no future. I see applications of an
Open Source-style license, but as a religion? As an ability to judge a
person based on some sort of Open Source-defined morality? Nope... no
future.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

