Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135486AbRDSASE>; Wed, 18 Apr 2001 20:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135487AbRDSARy>; Wed, 18 Apr 2001 20:17:54 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:15108 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S135486AbRDSARk>;
	Wed, 18 Apr 2001 20:17:40 -0400
Message-ID: <3ADE2EBD.8A875AE1@megapathdsl.net>
Date: Wed, 18 Apr 2001 17:18:05 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Prader <gnea@rochester.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE New Open Source X server
In-Reply-To: <Pine.LNX.4.10.10104181317440.1478-100000@www.transvirtual.com> <15070.4428.345455.994818@pizda.ninka.net> <20010418192824.A21365@rochester.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Prader wrote:
> 
> * David S. Miller (davem@redhat.com) uttered:
> >
> > James Simmons writes:
> >  >     The Linux GFX project grew out the need for a higher performance X
> >
> > And this specific functionality is?
> >
> > I think this is not a worthwhile project at all.  The X tree, it's
> > assosciated protocols and APIs, are complicated enough as it is, and
> > the xfree86 project has some of the most talented and capable people
> > in this area.  It would be a step backwards to do things outside of
> > xfree86 development.
> >
> > If the issue is that "things don't happen fast enough in the xfree86
> > tree", why not lend them a hand and submitting patches to them instead
> > of complaining?
> 
> You see, it's people like you that actually further along projects such
> as that.. "oh, it'll never work! blahblahblah!" well gee, X _has_ been
> around for years....... but so's microsoft........ so we've all gotten
> into this paradigm that linux is THE end solution for microsoft users...
> got news for ya bud, Linux is great, it's dope, but quite frankly, if u
> put all yer eggs in one basket, you become blind to everything else....
> and bill gates likes that......... but WAIT! someone ELSE comes along with an
> open project.... and what do you do? u take a hateful stance to it... do
> we see a pattern here?  you'd have to be pretty blind not to.

Take a chill pill, dude.

Dave's questions are perfectly valid.  Obviously, if a bunch of 
kick-butt programmers want to go off a create a "from-scratch" 
X11 implementation, please go right ahead!  If it turns out to 
be great (have rock-solid support for legacy apps, have screaming 
fast accellerated graphics drivers for all major hardware, support 
anti-aliased fonts, alpha-blending and so on in a way that is 
compatible with XFree86 APIs) then, sure, I'll switch over to the 
new X Server.  Of course, in the seven years that this project 
will take, XFree86 will have evolved quite a bit.

I suppose the new X Server could jettison support for legacy 
apps and only support applications written with the latest RAD 
toolkits.  There might be some value there.  This might also 
allow the new server to stabilize sooner.

	Miles
