Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVJLTen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJLTen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJLTen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:34:43 -0400
Received: from remus.commandcorp.com ([130.205.32.4]:56267 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S1750708AbVJLTen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:34:43 -0400
Subject: Re: [PATCH 2.6.14-rc4] Maintainers one entry removed
From: "Michael H. Warfield" <mhw@wittsend.com>
Reply-To: mhw@wittsend.com
To: Jiri Slaby <jirislaby@gmail.com>
Cc: mhw@wittsend.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jiri Slaby <xslaby@fi.muni.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, mhw@commandcorp.com,
       m.warfield@computer.org, warfieldm@acm.org
In-Reply-To: <4af2d03a0510121137h2c89ee1fw35109a41351a8b2e@mail.gmail.com>
References: <4af2d03a0510061516t32a62180t380dcb856d45a774@mail.gmail.com>
	 <20051012170612.619C422AF21@anxur.fi.muni.cz>
	 <1129143366.7966.19.camel@localhost.localdomain>
	 <4af2d03a0510121137h2c89ee1fw35109a41351a8b2e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4mjOHlR8VXRVzM+0Juui"
Organization: Thaumaturgy & Speculms Technology
Date: Wed, 12 Oct 2005 15:14:43 -0400
Message-Id: <1129144483.20250.16.camel@canyon.wittsend.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 (2.4.0-2) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4mjOHlR8VXRVzM+0Juui
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-10-12 at 20:37 +0200, Jiri Slaby wrote:
> On 10/12/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Mer, 2005-10-12 at 19:06 +0200, Jiri Slaby wrote:
> > > Maintainers one entry removed
> > >
> > > Computone intelliport multiport card is no longer maintained. The
> > > maintainer doesn't respond to e-mails (3 times during 1 month). The p=
age was
> > > updated 2 years ago and there is no other contact.

> > Michael posted to fedora-list on October 1st and seems active. Have you
> > allowed for the fact he might be away, busy or that you could be in his
> > spam filters ?
> So let's try his other e-mails, which I was not able to find before. Than=
ks.

	I'm still here and still responding to mhw@wittsend.com.  You may have
gotten caught up in a spam filter.  IAC...  I don't recall getting any
messages.  I have had contact with others on that address and I posted
to LKML back early this year that I was still alive after Andrew Morton
chimed in that I was still around and WittsEnd was still around.

> Hello Michael, is the Computone intelliport multiport card still
> maintained [and are you going to rewrite it to pci probing and the new
> api?] and/or mhw@wittsend.com e-mail from MAINTAINERS still active (as
> Alan wrote, I could be at on your black-list). So could you reply and
> tell us?

	You're not on a black list but CRM-114 may have caught you anyways.

	I spoke with Andrew about the Computone driver when we were both
speaking at Linux Lunacy last week.  I still intend to maintain it an
I've been working on the 2.6 driver.  I've got a spinlock problem that
has me in a bind at the moment with the patches.  I jokingly told Andrew
that he would get the patch as soon as I shot this problem and I was not
going to be like some people who sends him patches that don't even
compile.  :-)

	I thought the PCI stuff was there.  I'll look that over and see what
needs to be done.  Got some pointers to docs on what I need to update
for that?  I was talking to Andrew about the spinlock problems but he
didn't say anything about PCI probing.  What's missing?

> thanks,
> --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> ~\-/~      jirislaby@gmail.com      ~\-/~
> B67499670407CE62ACC8 22A032CC55C339D47A7E

	Mike
--=20
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com =20
  /\/\|=3Dmhw=3D|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/=
mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

--=-4mjOHlR8VXRVzM+0Juui
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQ01go+HJS0bfHdRxAQI48wP+NsjAgHLHLpFWvWaDHb0QiKX73dZhn9cz
CneOyjN6ItJL7cay14JC7ivmbzl1EH2togrebUyY9tJQBZcuzMIZ46wuGSdDFWBG
51269EEK+oIN/FEJqAaJ/qdRHheqf0xPoULvC4alBk2P6rg1QIAqaVQnlAPeFiF4
v258RSuYjj8=
=6QVR
-----END PGP SIGNATURE-----

--=-4mjOHlR8VXRVzM+0Juui--

