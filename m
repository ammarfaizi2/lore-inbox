Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSKBXjO>; Sat, 2 Nov 2002 18:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSKBXjM>; Sat, 2 Nov 2002 18:39:12 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:6161 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261520AbSKBXjK> convert rfc822-to-8bit;
	Sat, 2 Nov 2002 18:39:10 -0500
From: Nero <neroz@iinet.net.au>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Date: Sun, 3 Nov 2002 09:43:13 +1100
User-Agent: KMail/1.4.6
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <20021102232836.GD731@gallifrey>
In-Reply-To: <20021102232836.GD731@gallifrey>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211030943.13730.neroz@iinet.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 10:28 am, Dr. David Alan Gilbert wrote:
> * Patrick Finnegan (pat@purdueriots.com) wrote:
> > On 2 Nov 2002, Alan Cox wrote:
> > > On Sat, 2002-11-02 at 20:36, Dr. David Alan Gilbert wrote:
> > > > Oh please....
> > > > Wouldn't it be more helpful to iron the (few) small glitches out of
> > > > the qt based one than write a new one just because you don't happen
> > > > to like the library?
> > >
> > > Lota of installations have gtk but don't have qt.
> >
> > And a lot of installations have QT but not GTK... This feels like a vi vs
> > emacs discussion.
> >
> > Personally, it makes no difference to me which library is used.  I'm
> > doubtful I'll use anything other than menuconfig unless it makes my life
> > a *whole* lot easier. I'd say 'choose one and get on with it.'
>
> Exactly my point.  I just don't see the point in spending the neuron
> hours on both.
>
> But you guys who are worried about space and dependencies always can:
>    1) use menuconfig

OR, we could use the logical choice. GTK+ is on most systems, has hardly any 
dependancies, is relatively small (compared to Qt) and doesn't require a C++ 
compiler. Really, I think the only people being religious here are the ones 
voting for Qt, as it just doesn't make sense to use it for such a thing. If 
you absolutely hate GTK+, there is menuconfig, and IIRC KDE have their own 
[external] kernel configurator utility.

(and before anyone tries to jump on me for being a gtk zealot - I'm not. I run 
KDE as my primary desktop, so I'm quite fond of Qt. That doesn't mean it 
makes any more sense in a kernel however ;))
