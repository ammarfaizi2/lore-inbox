Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbTLaAqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265908AbTLaAqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:46:55 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:3345 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S265904AbTLaAqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:46:52 -0500
Date: Tue, 30 Dec 2003 18:46:44 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Tomas Szepe <szepe@pinerecords.com>
cc: DervishD <raul@pleyades.net>, Eugene <spamacct11@yahoo.com>,
       linux-kernel@vger.kernel.org,
       "ynezz @ hysteria. sk" <ynezz@hysteria.sk>
Subject: Re: best AMD motherboard for Linux
In-Reply-To: <20031230194203.GA8062@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.58.0312301354130.765@uberdeity>
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk>
 <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD>
 <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity>
 <20031230194203.GA8062@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003, Tomas Szepe wrote:

> On Dec-30 2003, Tue, 12:32 -0600
> Derek Foreman <manmower@signalmarketing.com> wrote:
>
> > > > > planning to get GeForce FX graphics card, if it makes a difference.
> > > >
> > > >     Ask here before if you are planning to change your video card.
> > >
> > > nVidia translates to "trouble" around here.  Selected Radeon cards,
> > > on the other hand, work perfectly with opensource drivers and should
> > > perform comparably.
> >
> > I'm not sure how you're defining "comparably".  If you mean they get
> > similar numbers from glxgears, that's possible.  But the feature sets are
> > not at all comparable.  Nvidia's linux driver actually exposes the
> > features available on modern graphics hardware.
> >
> > If you're going to advise against the use of their products in a public
> > forum, I suggest you be a lot more specific.
>
> The person asking for advice was very articulate in what their primary
> concerns in choosing hardware were, and my suggestion was made with those
> in mind.

His primary requirement was that it (the motherboard) work well with
linux.  He stated that he was capable of installing drivers if he had to,
but it would be even better if it wasn't required.

Open source drivers, or whether nvidia fits your idea of a "linux
supporting company" were not on the stated list of requirements.

In fact, the message wasn't even asking for an opinion on the graphics
card.

>            Yes, I'm convinced that a binary only driver is not an adequate
> solution in "supporting linux."

Paying people to write the driver, write documentation for the driver, and
provide technical support for the driver does not meet your requirements
for "supporting linux"...  Your requirements seem steep indeed.

There are a lot of drivers in the linux source tree itself that are
just as closed to you and I as the nvidia ones.  Lots of companies only
give out their documentation under NDA to "appropriate open source
developers" (I thought one of the great things about opensource was that
everyone was an "appropriate developer").  So while we can look at the
source code, we don't have enough information about it to provide adequate
peer review or to fix bugs in it ourselves.

We still have to contact whoever has the complete documentation, and we
still have to wait for them to make a fix available.

> And by the way, you are not being specific in naming the "features
> available on modern graphics hardware," either.

Vertex programs, fragment programs, vertex buffer objects, to name a few
things.  These are also available in the closed source ATI drivers.

Run glxinfo and look at the gl version strings and the supported
extensions.  I'll send you the output of mine off-list if you'd like to do
a comparison.

If you really do have specific complaints about nvidia's drivers, it
would be polite to email them first - they do reply to their linux-bugs
email address.

Just claiming "nvidia translates into trouble" is really nothing more
than FUD.
