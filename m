Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVAMUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVAMUui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVAMUsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:48:38 -0500
Received: from grendel.firewall.com ([66.28.58.176]:48033 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261383AbVAMUoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:44:18 -0500
Date: Thu, 13 Jan 2005 21:44:15 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113204415.GF24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <1105643984.5193.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <1105643984.5193.95.camel@localhost.localdomain>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 07:19:45PM +0000, Alan Cox scribbled:
> On Iau, 2005-01-13 at 19:42, Marek Habersack wrote:
> > On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
> > > We cannot do this without the reporters permission. Often we get
> > I think I don't understand that. A reporter doesn't "own" the bug - not=
 the
> > copyright, not the code, so how come they can own the fix/report?
>=20
> They own the report. Who owns it is kind of irrelevant. If we publish it
> when they don't want it published then next time they'll send it to
> full-disclosure or worse still just share an exploit with the bad guys.
> So unless we get really stoopid requests we try not to annoy people -
> hole reporting is a volunatry activity
Sounds a bit backwards to me. It's like surrendering to a guy who attacks y=
ou
on the street "because he's got a knife and I don't". There is some sense in
it, but that way you're putting yourself in a position of a victim. The
reporters... ok, they own the report, but do they own the information?

> > > material that even the list isn't allowed to directly see only by
> > > contacting the relevant bodies directly as well. The list then just
> > > serves as a "foo should have told you about issue X" notification.
> > This sounds crazy. I understand that this may happen with proprietary
> > software, or software that is made/supported by a company but otherwise=
 opensource
> > (like OpenOffice, for instance), but the kernel?
>=20
> Its not uncommon. Not all security bodies (especially government
> security agencies) trust vendor-sec directly, only some members on the
> basis of their own private auditing/background checks.
So it sounds that we, the men-in-the-crowd are really left out in the crowd,
people who are affected the most by the issues. Since the vendors are not
affected by the bugs (playing a devil's advocate here), since they fix them
for their machines as they appear, way before they get public.

best regards,

marek

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5t2fq3909GIf5uoRAoxvAJ4pglnIa2qzqI6z8Evh2/I9n9bM5wCdFnpU
+VcWO77idxsSONqZME2eGB8=
=8iOj
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
