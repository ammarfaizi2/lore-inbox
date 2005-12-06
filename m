Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbVLFONJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbVLFONJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVLFONJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:13:09 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:32297 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751463AbVLFONI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:13:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YmJkwXjHqYtxHMe2i6GO6IU28dMNTg7ViQg+dM+An6qMJ2apw04Z7aNGjkgVCRt1ljLj+JSB1yo6HcZEkqkWAROFtBp1bZ66XsxpKLt/+pO0HsvtMwbZG07ypJgcXyJqmp9N9+/MmsjLc19oTAB9o5z6CvtDc80DfX5PucneJXo=
Message-ID: <a03c9a270512060613t30397e70k2b45c981a9709a61@mail.gmail.com>
Date: Tue, 6 Dec 2005 15:13:07 +0100
From: Rudolf Randal <rudolf.randal@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4394ECA7.80808@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
	 <43944F42.2070207@didntduck.org> <20051206030828.GA823@opteron.random>
	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	 <1133869465.4836.11.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Brian Gerst <bgerst@didntduck.org> wrote:
> Arjan van de Ven wrote:
> > On Tue, 2005-12-06 at 12:07 +0100, M. wrote:
> >>
> >> On 12/6/05, Andrea Arcangeli <andrea@suse.de> wrote:
> >>         On Mon, Dec 05, 2005 at 09:31:30AM -0500, Brian Gerst wrote:
> >>         > The problem with this statement is that Linux users are a
> >>         drop in the
> >>         > bucket of sales for this hardware.  Boycotting doesn't cost
> >>         the vendors
> >>         > enough to make them care.  And this does nothing for people
> >>         who are
> >>         > converting over to Linux, and didn't buy hardware with that
> >>         > consideration in mind.
> >>
> >>         Effectively this is why 3d drivers are the only thing we
> >>         litearlly lost
> >>         control of. But my email was general. I wasn't only speaking
> >>         of 3d
> >>         hardware.
> >>
> >>         For 3d you're very well right, but once linux becomes
> >>         mainstream in the
> >>         desktop, things could change.
> >>
> >> Without proper hardware support linux is not going to become
> >> mainstream in the desktop area. In fact It's adopted in offices, by
> >> governments and schools for security, reliability and openoffirce.org
> >> (low $$).
> >
> > but... "proper hardware support" can be open source, that's the whole
> > point! Everyone considering binary only support "full" causes the entire
> > problem of not being able to run without binary modules anymore, which
> > in turn means you're either stuck with enterprise distro kernels, or
> > linux is stuck with a kernel that can't be developed on anymore in a 2.7
> > style series.
> >
> > Nobody is arguing that hardware shouldn't be supported, to the contrary.
> > I and others are arguing that short term binary only "support" isn't
> > real support in the long term, and in both the long and short term leads
> > to a significant reduction in choice. Note: NVidia right now is nice
> > enough to do the blob+glue layer thing. Many others don't, they only
> > provide modules for certain enterprise distros. Now those schools and
> > governments of course run those enterprise distros... but what does that
> > gain in the end? Security? It doesn't; several of these binary modules
> > actually introduce security holes (the most famous one is an old 3D
> > driver of a company I won't name that had a "make me root" ioctl).
> > Price? Well those enterprise distribution companies need to make money
> > somehow... so while the price may be lower... you're stuck to them
> > again..
> >
> >> So , without some sort of effort from kernel developers, things
> >> arent going to change.
> >
> > I would turn this around; without some sort of effort from the USERS,
> > things aren't going to change. As long as USERS don't use their purchase
> > power to urge vendors that linux and open source are important, nothing
> > is going to improve. Going binary is not a long term improvement! It's
> > more like a quick shot of heroin that makes you feel better today,
> > rather than going to a psychiatrist who helps you out of your depression
> > for the rest of your life.
>
> Once again I'd like to point out that user's purchase power means jack
> when they only have two choices for video:  ATI and Nvidia.  You can't
> walk into a computer store and find anything else (I don't count
> integrated video on the motherboard as a solution, since only Intel
> boards have it, sorry AMD users).  Even over the web it's hard to find
> anything else.  I'm not trying to defend closed source here, but you
> people just have to face the reality that trying to use the market to
> get our way is just not going to work with video.  The only way forward
> is reverse engineering.  We aren't going to get help from the vendors so
> we have to help ourselves.
>

Well - reverse engineering isnt gonna get any easier over time .. as
hardware gets more complex and bus speed increases it will become more
and more impossible to do any probing?. There also isnt any way to
ensure that vendors wont go down the m$ way as on the xbox or xbox360
and encrypt data between chips to protect their IP.
Most likely that will prevent the reversely engineered driver from
getting out in time before the next generation of hardware arrives ?





--
Rudolf Randal - Hässleholmsgatan 3B lgh 503 - 214 43 Malmö - Sweden -
Phone: +46 (0)76 234 05 77
