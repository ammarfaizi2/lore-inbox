Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUF2WBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUF2WBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUF2WBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:01:40 -0400
Received: from wblv-36-194.telkomadsl.co.za ([165.165.36.194]:24516 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266097AbUF2WBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:01:35 -0400
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "David S. Miller" <davem@redhat.com>
Cc: John Heffner <jheffner@psc.edu>, shemminger@osdl.org,
       debi.janos@freemail.hu,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Kurt Lieber <klieber@gentoo.org>
In-Reply-To: <20040629145311.1734e2e6.davem@redhat.com>
References: <20040629140242.1e274ffb@dell_ss3.pdx.osdl.net>
	 <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
	 <20040629145311.1734e2e6.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vNjbrJfIWiM9/pU1WzLz"
Message-Id: <1088546303.14761.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 23:58:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vNjbrJfIWiM9/pU1WzLz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-29 at 23:53, David S. Miller wrote:
> On Tue, 29 Jun 2004 17:36:45 -0400 (EDT)
> John Heffner <jheffner@psc.edu> wrote:
>=20
> > Sigh.  I ran in to this problem a year or so ago and it was a broken
> > firewall that was mangling the TCP window scale option.  I think the
> > firewall was an OpenBSD machine, and I was told the problem went away w=
ith
> > an upgrade.  I'm curious what they're running here.
> >=20
> > The boundary 3 is special because it causes SWS avoidance to break.
>=20
> Interesting data-point, thanks John.
>=20
> Can someone go figure out what packages.gentoo.org is using
> as a firewall/router?

I forwarded one of the previous mails in the thread to Kurt Lieber
who should know what is the setup there, or who to speak to.


Cheers,


--=20
Martin Schlemmer

--=-vNjbrJfIWiM9/pU1WzLz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4eX/qburzKaJYLYRAqU6AJ9IpcWK4O2gykeBW/ZIJSt0wnQjWQCggWDw
zcHshSP2GiupMjfHHUmcX10=
=rr9w
-----END PGP SIGNATURE-----

--=-vNjbrJfIWiM9/pU1WzLz--

