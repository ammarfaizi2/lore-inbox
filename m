Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSK0UCH>; Wed, 27 Nov 2002 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSK0UCH>; Wed, 27 Nov 2002 15:02:07 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62184 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264739AbSK0UCA>; Wed, 27 Nov 2002 15:02:00 -0500
Date: Wed, 27 Nov 2002 21:09:01 +0100
From: Martin Waitz <tali@admingilde.org>
To: Frederik Dannemare <tux@sentinel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limiting max cpu usage per user (old Conectiva patch)
Message-ID: <20021127200901.GA1143@admingilde.org>
Mail-Followup-To: Frederik Dannemare <tux@sentinel.dk>,
	linux-kernel@vger.kernel.org
References: <3DE49A66.4020208@sentinel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <3DE49A66.4020208@sentinel.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Wed, Nov 27, 2002 at 11:11:50AM +0100, Frederik Dannemare wrote:
> do we have an effective way to limit max cpu usage per user?

i'm working on a resource container implementation for linux
for my diploma thesis.

resource container provide a hierarchical way to account and
limit resources.
this way not only per user limits can be achieved, but any
policy you can think of (per service, per client, ...)

the work is due january, but interested people could have
a look at the (undocumented for now ;) source earlier.

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE95SZdj/Eaxd/oD7IRAhmuAKCEvCNiiZchBF6/7TPUq6b0OVJzhwCbBH+A
i/2LNG/bOYfTvxyUk4QtgJ0=
=nZil
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
