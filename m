Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKCAAD>; Sat, 2 Nov 2002 19:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSKCAAD>; Sat, 2 Nov 2002 19:00:03 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:33544 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S261550AbSKCAAB>; Sat, 2 Nov 2002 19:00:01 -0500
Date: Sat, 2 Nov 2002 19:07:29 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Nero <neroz@iinet.net.au>
cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <200211030943.13730.neroz@iinet.net.au>
Message-ID: <Pine.LNX.4.44.0211021858540.16432-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Nero wrote:

> On Sun, 3 Nov 2002 10:28 am, Dr. David Alan Gilbert wrote:
> > * Patrick Finnegan (pat@purdueriots.com) wrote:
> > > On 2 Nov 2002, Alan Cox wrote:
> > > > On Sat, 2002-11-02 at 20:36, Dr. David Alan Gilbert wrote:
> > > > > Oh please....
> > > > > Wouldn't it be more helpful to iron the (few) small glitches out of
> > > > > the qt based one than write a new one just because you don't happen
> > > > > to like the library?
> > > >
> > > > Lota of installations have gtk but don't have qt.
> > >
> > > And a lot of installations have QT but not GTK... This feels like a vi vs
> > > emacs discussion.
> > >
> > > Personally, it makes no difference to me which library is used.  I'm
> > > doubtful I'll use anything other than menuconfig unless it makes my life
> > > a *whole* lot easier. I'd say 'choose one and get on with it.'
> >
> > Exactly my point.  I just don't see the point in spending the neuron
> > hours on both.
> >
> > But you guys who are worried about space and dependencies always can:
> >    1) use menuconfig
>
> OR, we could use the logical choice. GTK+ is on most systems, has hardly any
> dependancies, is relatively small (compared to Qt) and doesn't require a C++
> compiler. Really, I think the only people being religious here are the ones
> voting for Qt, as it just doesn't make sense to use it for such a thing. If
> you absolutely hate GTK+, there is menuconfig, and IIRC KDE have their own
> [external] kernel configurator utility.
>
> (and before anyone tries to jump on me for being a gtk zealot - I'm not. I run
> KDE as my primary desktop, so I'm quite fond of Qt. That doesn't mean it
> makes any more sense in a kernel however ;))

I would agree with that if no code was written for Qt.  However, (as I
understand it) there's a basically functional version for Qt.  Keep what's
there and works, and encourage one to be written for GTK by those who
have the spare time, but don't scrap the Qt one just because some people
don't like Qt.

--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



