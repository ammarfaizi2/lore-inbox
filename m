Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279581AbRKMWAq>; Tue, 13 Nov 2001 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKMWAg>; Tue, 13 Nov 2001 17:00:36 -0500
Received: from air-1.osdl.org ([65.201.151.5]:39697 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279589AbRKMWAV>;
	Tue, 13 Nov 2001 17:00:21 -0500
Date: Tue, 13 Nov 2001 14:00:02 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Dan Kegel <dank@kegel.com>
cc: "Timothy D. Witham" <wookie@osdl.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <stp@osdl.org>
Subject: STP for automated GCC testing  (was Re: Regression testing of 2.4.x
 beforerelease?)
In-Reply-To: <3BF0A748.A68251C6@kegel.com>
Message-ID: <Pine.LNX.4.33.0111131343500.28266-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Dan Kegel wrote:
> "Timothy D. Witham" wrote:
> >
> > On Sun, 2001-11-11 at 22:24, Dan Kegel wrote:
> > > At some point it might be nice to also use the STP to help
> > > speed gcc 3 development, too.  (I personally am really
> > > looking forward to the day when I can use the same compiler
> > > for both c++ and kernel.)
> >
> >   Strange, I was just talking to somebody about compiler
> > performance and regression issues and what sort of automation
> > could be done to do that sort of testing.
> >
> >   Since the STP is really a framework and just about any piece
> > of software and testing environment could be worked into it.
> >
> >  So I guess you could have two pieces.  One that just ran a bunch
> > of compile and user level tests and then one that went in and
> > checked out the compiler on a kernel tree and then ran the
> > same performance tests that had been run using the "standard"
> > compiler.
>
> Go/no-go tests, where you make sure a kernel compiled with gcc 3
> actually works, might be appropriate for starters.  I don't know
> if that's been established yet.
>
> >   Are you stepping forward to integrate this into STP? :-)
>
> I wish!  Alas, tendinitis makes hacking hazardous for me for now.
>

Dan, I'd be willing to join in with some of the hacking.  I helped
develop STP so am familiar with how it works and how to apply it to
this.  I've used/compiled/cursed at gcc for years but am not super
familiar with its internals, so would welcome some advice and help
there.

Would anyone else be interested in joining in on doing this?  I think
providing this testing service for gcc would be invaluable for the
community.  Basically we need a couple folks with perl scripting and
html form creation skills.

Anyway, if I get a few positive responses and it's okay by Tim, I'll go
ahead and get a mailing list, etc. set up for everyone interested in
joining in on this.

Bryce



