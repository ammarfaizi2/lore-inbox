Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWG3P5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWG3P5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWG3P5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:57:41 -0400
Received: from nsm.pl ([195.34.211.229]:276 "EHLO nsm.pl") by vger.kernel.org
	with ESMTP id S932338AbWG3P5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:57:40 -0400
Date: Sun, 30 Jul 2006 17:57:34 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730155734.GA13377@irc.pl>
Mail-Followup-To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Pavel Machek <pavel@suse.cz>, Jirka Lenost Benc <jbenc@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20060730112827.GA25540@srcf.ucam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2006 at 12:28:27PM +0100, Matthew Garrett wrote:
> On Sun, Jul 30, 2006 at 12:40:42PM +0200, Pavel Machek wrote:
>=20
> > I'm unfortunate enough to have x60 with ipw card. Card works okay, but
> > driver is 16K LoC and needs binary daemon (ugh). Plus, it lives as an
> > external module...
>=20
> I have a mostly working replacement for the binary daemon, but it causes=
=20
> the firmware to crash at the point where it triggers an association. If=
=20
> anyone's keen on trying to figure out what's up, I'll clean up the code=
=20
> and stick it somewhere.

  Is your daemon somehow releated to wifi frequencies goegraphy database
proposed some time ago on netdev?

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEzNbuThhlKowQALQRAv0KAJ961QBiLrcd5b+EeQRsSWyky2R19ACfXyH4
hjJwrmwhZsDq8GDZ5coGFxo=
=/G9M
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
