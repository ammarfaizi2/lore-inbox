Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVA0Xur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVA0Xur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVA0XtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:49:13 -0500
Received: from mail.tmr.com ([216.238.38.203]:14857 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261312AbVA0XcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:32:14 -0500
Date: Thu, 27 Jan 2005 18:20:34 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Zan Lynx <zlynx@acm.org>
cc: Jesse Pollard <jesse@cats-chateau.net>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <1106846314.15927.6.camel@localhost>
Message-ID: <Pine.LNX.3.96.1050127181446.32523B-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY="=-NOc6nkdXpvjonoz+seiq"
Content-ID: <Pine.LNX.3.96.1050127181446.32523C@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--=-NOc6nkdXpvjonoz+seiq
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.3.96.1050127181446.32523D@gatekeeper.tmr.com>

On Thu, 27 Jan 2005, Zan Lynx wrote:

> On Thu, 2005-01-27 at 10:37 -0600, Jesse Pollard wrote:
> > On Wednesday 26 January 2005 13:56, Bill Davidsen wrote:
> > > On Wed, 26 Jan 2005, Jesse Pollard wrote:
> > > > On Tuesday 25 January 2005 15:05, linux-os wrote:
> > > > > This isn't relevant at all. The Navy doesn't have any secure
> > > > > systems connected to a network to which any hackers could connect.
> > > > > The TDRS communications satellites provide secure channels
> > > > > that are disassembled on-board. Some ATM-slot, after decryption
> > > > > is fed to a LAN so the sailors can have an Internet connection
> > > > > for their lap-tops. The data took the same paths, but it's
> > > > > completely independent and can't get mixed up no matter how
> > > > > hard a hacker tries.
> > > >
> > > > Obviously you didn't hear about the secure network being hit by the "I
> > > > love you" virus.
> > > >
> > > > The Navy doesn't INTEND to have any secure systems connected to a network
> > > > to which any hackers could connect.
> > >
> > > What's hard about that? Matter of physical network topology, absolutely no
> > > physical connection, no machines with a 2nd NIC, no access to/from I'net.
> > > Yes, it's a PITA, add logging to a physical printer which can't be erased
> > > if you want to make your CSO happy (corporate security officer).
> > 
> > And you are ASSUMING the connection was authorized. I can assure you that 
> > there are about 200 (more or less) connections from the secure net to the
> > internet expressly for the purpose of transferring data from the internet
> > to the secure net for analysis. And not ALL of these connections are 
> > authorized. Some are done via sneakernet, others by running a cable ("I need
> > the data NOW... I'll just disconnect afterward..."), and are not visible
> > for very long. Other connections are by picking up a system and carrying it
> > from one connection to another (a version of sneakernet, though here it
> > sometimes needs a hand cart).
> > 
> > > > Unfortunately, there will ALWAYS be a path, either direct, or indirect
> > > > between the secure net and the internet.
> > >
> > > Other than letting people use secure computers after they have seen the
> > > Internet, a good setup has no indirect paths.
> > 
> > Ha. Hahaha...
> > 
> > Reality bites.
> 
> In the reality I'm familiar with, the defense contractor's secure
> projects building had one entrance, guarded by security guards who were
> not cheap $10/hr guys, with strict instructions.  No computers or
> computer media were allowed to leave the building except with written
> authorization of a corporate officer.  The building was shielded against
> Tempest attacks and verified by the NSA.  Any computer hardware or media
> brought into the building for the project was physically destroyed at
> the end.

That sounds familiar... Doing any of the things mentioned above would (if
detected) result in firing on the spot, loss of security clearance, and a
stunningly bad reference if anyone did an employment check.

Not to mention possible civil or criminal prosecution in some cases.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--=-NOc6nkdXpvjonoz+seiq
Content-Type: APPLICATION/PGP-SIGNATURE; NAME="signature.asc"
Content-ID: <Pine.LNX.3.96.1050127181446.32523E@gatekeeper.tmr.com>
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB+SJqG8fHaOLTWwgRAlJFAJ0X4gnFk05Oj0oQwkf9J20PsbHsIwCgoZQz
tYX5r3RoNw/gLWsJAelDw5c=
=bON8
-----END PGP SIGNATURE-----

--=-NOc6nkdXpvjonoz+seiq--
