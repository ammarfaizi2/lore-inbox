Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154279AbQBFWx0>; Sun, 6 Feb 2000 17:53:26 -0500
Received: by vger.rutgers.edu id <S154134AbQBFWxN>; Sun, 6 Feb 2000 17:53:13 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:2888 "EHLO alcove.wittsend.com") by vger.rutgers.edu with ESMTP id <S154287AbQBFWvJ>; Sun, 6 Feb 2000 17:51:09 -0500
Date: Sun, 6 Feb 2000 22:06:30 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.rutgers.edu
Subject: Re: Encrypted File systems implementation into the kernel?
Message-ID: <20000206220630.G20854@alcove.wittsend.com>
References: <3896746B.86861D7F@hackersclub.com> <68198940cfcc6b22@home-box.demon.co.uk> <20000206124232.H20611@alcove.wittsend.com> <87ktme$bnd$1@cesium.transmeta.com> <20000206205821.J20611@alcove.wittsend.com> <389E280C.2362FF21@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.2i
In-Reply-To: <389E280C.2362FF21@transmeta.com>; from hpa@transmeta.com on Sun, Feb 06, 2000 at 06:03:56PM -0800
Sender: owner-linux-kernel@vger.rutgers.edu

	Hmmm...  We're starting to get a wee bit off topic here (outside
of the fact that this affects kernel.org) but government bashing is such
fun and all the rage lately.  ;-/

On Sun, Feb 06, 2000 at 06:03:56PM -0800, H. Peter Anvin wrote:
> "Michael H. Warfield" wrote:

> > > The biggest issue in the new U.S. regulations is the "foreign
> > > government" provision.  I intend to file a comment recommending that
> > > this provision be removed, since it is inherently unworkable.  This
> > > provision prohibits someone in the U.S. from "knowingly" export to a
> > > foreign government end-user (*any* foreign government, not just T-7.)
> > > This is of course idiotic, since it just takes someone *else* in that
> > > country downloading the stuff and giving to their government -- or the
> > > government getting an ISP account making them look like someone else.
> > > Whomever does that would be breaking U.S. law, but that's meaningless
> > > since they're outside U.S. jurisdiction.

> >         I saw that...  Things like checking for .mil and .gov client sites.
> > How BOGUS!  Still, only applies to binaries and not to open source software
> > SOURCES but that's little solace since Linus said that you planned to
> > include some binaries on the site.

> *Especially* bogus since .mil and .gov are TLDs used by the *U.S.*
> government, quite specifically!!!!  They also said to watch out for
> .gouv, which isn't even a domain.

	Mmmmm....  I thought I saw something about mil and gov under
geographic TLDs.  I'll have to go back and double check.  Make sure
they aren't requiring that you check for "bogon.mil.to" and "foo.gov.au"
somewhere in there.  I could be wrong (sure as hell wouldn't be the
first time), but I thought that they were.

	I have no idea where that .gouv came from.  I just about hit the
ceiling when I first saw that in the changes.  I was begining to yell
"WHAT ARE THEY SMOKING?" when I stopped and thought for a minute.  ICANN
is in the cat bird seat now.  They are suppose to be creating new TLDs.
Anything is possible.  Especially if you factor in the geographic domains.
Rather than ASSUME that they are idiots with an extreme case of optical
rectitus, I wonder if they know something or expect something we don't.
I'm sure that if there is a kremvax.gouv.ru out there, they would know about
it and we wouldn't give a damn.  This was an act of commission, not omission.
When the government does something stupid like that, the first thing you
do is check to see why they didn't thing that it was stupid when they did
it.  Then (to quote the author of "Myth Adventures") if you think you have
them figured out and you've got a good deal, go back and "count your
fingers, count your toes, and count your relatives" because someone is
about to get short changed.

> 	-hpa

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (770) 331-2437   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
