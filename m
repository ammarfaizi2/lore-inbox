Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269217AbUIBWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269217AbUIBWCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269180AbUIBV71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:59:27 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:48133 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S269196AbUIBV6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:58:20 -0400
Date: Thu, 2 Sep 2004 14:56:27 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902215627.GA15688@nietzsche.lynx.com>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <1094150760.5809.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094150760.5809.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:46:05PM +0100, Alan Cox wrote:
> On Iau, 2004-09-02 at 18:46, Linus Torvalds wrote:
> > > Gnome already supports this in the gnome-vfs2 layer. "MC" has supported
> > > it since the late 1990's.
> > 
> > And nobody has asked for kernel support that I know of.
> 
> I asked our desktop people. They want something like inotify because
> dontify doesn't cut it. They have zero interest in the multiple streams
> and hiding icons in streams type stuff.

It also depends on who you ask. I can't take a lot of the mainstream
X folks serious since they are still using integer math as parameters
to half broken drawing primitives and barely discovered things like OpenGL.
Their attitude doesn't treat these things as first class citizens in
what ever software system they create. They also haven't create a modern
and highly dynamic structured document system that's in wide use yet,
so this problem space hasn't really been pushed as hard as other much
more dynamic systems. And the advent of XML (basically a primitive and
flat model of what Hans is doing) for .NET style systems are going to
push these systems into those areas in new and unique ways. (Actually
retro Smalltalk-ish)

It seems that many of the original ideas about "why" GUI systems exist
have been lost to older commericial interests (Microsoft Win32) and that
has wiped out the fundamental classic computer science backing this from
history. This simple "MP3 metadata" stuff is a very superficial example
of how something like this is used.

The problems are fundamentally about data representation in a manner so
simple that its "expressive power" (Hans here) can extend itself to even
the dorkiest of shell scripts. To have that power immediately available
as network/local objects and to have their relationships clearly defined
is a very powerful manner to build software systems. 

Unix folks tend to forget that since they either have never done this
kind of programming or never understood why this existed in the first
place. It's about a top-down methodology effecting the entire design of
the software system, not just purity Unix. If it can be integrate
smoothly into the system, then it should IMO.

The folks against this system forget about how important the context of
all this is work is set in... The mindset is fundamentally different and
I'm quite sick of hearing "It's not Unix" over and over again. And
notion of Linux being marginalize to a minority OS over this stuff is
just plain crazy.
 
bill

