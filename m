Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbUAAGPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 01:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbUAAGPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 01:15:39 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:54532 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S265300AbUAAGPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 01:15:37 -0500
Date: Thu, 1 Jan 2004 00:15:31 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Tomas Szepe <szepe@pinerecords.com>
cc: DervishD <raul@pleyades.net>, Eugene <spamacct11@yahoo.com>,
       linux-kernel@vger.kernel.org,
       "ynezz @ hysteria. sk" <ynezz@hysteria.sk>
Subject: Re: best AMD motherboard for Linux
In-Reply-To: <20031231093929.GC8062@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.58.0312310914170.473@uberdeity>
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk>
 <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD>
 <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity>
 <20031230194203.GA8062@louise.pinerecords.com> <Pine.LNX.4.58.0312301354130.765@uberdeity>
 <20031231093929.GC8062@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Tomas Szepe wrote:

> On Dec-30 2003, Tue, 18:46 -0600
> Derek Foreman <manmower@signalmarketing.com> wrote:
>
> > His primary requirement was that it (the motherboard) work well with
> > linux.  He stated that he was capable of installing drivers if he had to,
> > but it would be even better if it wasn't required.
> >
> > Open source drivers, or whether nvidia fits your idea of a "linux
> > supporting company" were not on the stated list of requirements.
>
> Indirectly they were, if you admit that opensource drivers are "better"
> for Linux users.  The person's goal was, let me quote, "to make sure
> I get the hardware that works best with Linux."  I suggested they avoid
> nVidia, because _my opinion_ is that binary-only drivers do not "work best."

I think we're just going to have to disagree on what "work best" means.  I
choose to interpret it as a measure of driver functionality and
performance.

Your definition of "work best" is based on a political agenda, and not on
technical merit.

> > There are a lot of drivers in the linux source tree itself that are
> > just as closed to you and I as the nvidia ones.  Lots of companies only
> > give out their documentation under NDA to "appropriate open source
> > developers" (I thought one of the great things about opensource was that
> > everyone was an "appropriate developer").  So while we can look at the
> > source code, we don't have enough information about it to provide adequate
> > peer review or to fix bugs in it ourselves.
>
> Now, excuse me French, _this_ is a big load.  Come back when you've tried
> to find out how a piece of hardware works with and without working driver
> sources.

Excuse you indeed.  I have.

> > We still have to contact whoever has the complete documentation, and we
> > still have to wait for them to make a fix available.
>
> Ok, I might not be able to add support for a new revision of a chip,
> true enough.  Somebody will do it, eventually.  The important thing
> you're ignoring is -- if such a driver is oopsing my box, I will be
> able to fix it.

You will be able to fix a certain subset of possible problems.  Maybe you
can fix an OOPS or BUG if they're obvious enough, and have to do with
kernel interfaces and not the hardware itself.

If the driver is not properly accessing the hardware, and you don't
have the documentation, it's as much a black box to you as nvidia.o.

> > Just claiming "nvidia translates into trouble" is really nothing more
> > than FUD.
>
> No, it isn't.  Search the lkml archives for "OOPS Tainted nvdriver."

Of course it is.  And you're doing it again.  Performing that search
doesn't give any evidence that "nvidia is trouble", or even that their
graphics driver is unstable.  But the implication is that nvidia's drivers
will cause me problems.

This is getting quite unfocused.  My intended point is that saying "<foo>
is trouble" without any detail at all is misleading.  It gives the
impression that <foo> may not operate correctly, when the real issue at
hand here is that it is closed source.
