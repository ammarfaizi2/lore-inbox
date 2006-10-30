Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWJ3UHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWJ3UHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWJ3UHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:07:50 -0500
Received: from sirius.lasnet.de ([62.75.240.18]:18912 "EHLO sirius.lasnet.de")
	by vger.kernel.org with ESMTP id S1161445AbWJ3UHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:07:20 -0500
Date: Mon, 30 Oct 2006 20:52:43 +0100
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alasdair G Kergon <agk@redhat.com>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com, dm-crypt@saout.de,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] dmsetup table output changed from 2.6.18 to 2.6.19-rc3 and breaks yaird.
Message-ID: <20061030195243.GR27337@susi>
References: <20061030151930.GQ27337@susi> <20061030184331.GY3928@agk.surrey.redhat.com> <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iks5JP/frMpeeVyh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610301053010.25218@g5.osdl.org>
X-Mailer: Mutt http://www.mutt.org/
X-KeyID: 0xDDF51665
X-Website: http://www.datenfreihafen.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iks5JP/frMpeeVyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, 2006-10-30 at 11:00, Linus Torvalds wrote:
>=20
> (maybe something like this trivial one? Totally untested, but it would=20
> seem to be the sane approach)

I just tested it. Works fine for me.

regards
Stefan Schmidt

--iks5JP/frMpeeVyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: http://www.datenfreihafen.org/contact.html

iD8DBQFFRlgKbNSsvd31FmURApsMAKC0v3nPMQtU5bi781aCJOae8nmY8QCg2Szl
h2FXHPsB/bNy66/Df3l8vow=
=c3fw
-----END PGP SIGNATURE-----

--iks5JP/frMpeeVyh--
