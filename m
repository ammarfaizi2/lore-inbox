Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLaJkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTLaJkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:40:18 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:52639 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263891AbTLaJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:40:08 -0500
Date: Wed, 31 Dec 2003 10:39:30 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Derek Foreman <manmower@signalmarketing.com>
Cc: DervishD <raul@pleyades.net>, Eugene <spamacct11@yahoo.com>,
       linux-kernel@vger.kernel.org,
       "ynezz @ hysteria. sk" <ynezz@hysteria.sk>
Subject: Re: best AMD motherboard for Linux
Message-ID: <20031231093929.GC8062@louise.pinerecords.com>
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk> <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD> <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity> <20031230194203.GA8062@louise.pinerecords.com> <Pine.LNX.4.58.0312301354130.765@uberdeity>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301354130.765@uberdeity>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-30 2003, Tue, 18:46 -0600
Derek Foreman <manmower@signalmarketing.com> wrote:

> > > > nVidia translates to "trouble" around here.  Selected Radeon cards,
> > > > on the other hand, work perfectly with opensource drivers and should
> > > > perform comparably.
> > >
> > > I'm not sure how you're defining "comparably".  If you mean they get
> > > similar numbers from glxgears, that's possible.  But the feature sets are
> > > not at all comparable.  Nvidia's linux driver actually exposes the
> > > features available on modern graphics hardware.
> > >
> > > If you're going to advise against the use of their products in a public
> > > forum, I suggest you be a lot more specific.
> >
> > The person asking for advice was very articulate in what their primary
> > concerns in choosing hardware were, and my suggestion was made with those
> > in mind.
> 
> His primary requirement was that it (the motherboard) work well with
> linux.  He stated that he was capable of installing drivers if he had to,
> but it would be even better if it wasn't required.
> 
> Open source drivers, or whether nvidia fits your idea of a "linux
> supporting company" were not on the stated list of requirements.

Indirectly they were, if you admit that opensource drivers are "better"
for Linux users.  The person's goal was, let me quote, "to make sure
I get the hardware that works best with Linux."  I suggested they avoid
nVidia, because _my opinion_ is that binary-only drivers do not "work best."

> In fact, the message wasn't even asking for an opinion on the graphics
> card.

Yes and no, it did mention graphics hardware, and somebody started
a subthread in which I reacted.

> >            Yes, I'm convinced that a binary only driver is not an adequate
> > solution in "supporting linux."
> 
> Paying people to write the driver, write documentation for the driver, and
> provide technical support for the driver does not meet your requirements
> for "supporting linux"...

Indeed it doesn't -- this approach doesn't work for Linux.  Might work
for other operating systems, but it certainly doesn't work for Linux.

> Your requirements seem steep indeed.

Yes.

> There are a lot of drivers in the linux source tree itself that are
> just as closed to you and I as the nvidia ones.  Lots of companies only
> give out their documentation under NDA to "appropriate open source
> developers" (I thought one of the great things about opensource was that
> everyone was an "appropriate developer").  So while we can look at the
> source code, we don't have enough information about it to provide adequate
> peer review or to fix bugs in it ourselves.

Now, excuse me French, _this_ is a big load.  Come back when you've tried
to find out how a piece of hardware works with and without working driver
sources.

> We still have to contact whoever has the complete documentation, and we
> still have to wait for them to make a fix available.

Ok, I might not be able to add support for a new revision of a chip,
true enough.  Somebody will do it, eventually.  The important thing
you're ignoring is -- if such a driver is oopsing my box, I will be
able to fix it.

> > And by the way, you are not being specific in naming the "features
> > available on modern graphics hardware," either.
> 
> Vertex programs, fragment programs, vertex buffer objects, to name a few
> things.  These are also available in the closed source ATI drivers.
> 
> Run glxinfo and look at the gl version strings and the supported
> extensions.  I'll send you the output of mine off-list if you'd like to do
> a comparison.

No I don't, but thank you.

> If you really do have specific complaints about nvidia's drivers,
> it would be polite to email them first - they do reply to their
> linux-bugs email address.

No, thanks, I've had my share with nVidia's oopsing drivers.

> Just claiming "nvidia translates into trouble" is really nothing more
> than FUD.

No, it isn't.  Search the lkml archives for "OOPS Tainted nvdriver."

-- 
Tomas Szepe <szepe@pinerecords.com>
