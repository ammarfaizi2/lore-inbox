Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUCNRop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCNRop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:44:45 -0500
Received: from 62-43-47-234.user.ono.com ([62.43.47.234]:46240 "HELO
	mitago.net") by vger.kernel.org with SMTP id S261459AbUCNRon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:44:43 -0500
Date: Sun, 14 Mar 2004 18:44:41 +0100
From: Celso =?iso-8859-1?Q?Gonz=E1lez?= <celso@mitago.net>
To: Witold Krecicki <adasi@kernel.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: snd-powermac volume setting broken?
Message-ID: <20040314174441.GA12626@viac3>
Reply-To: celso@mitago.net
References: <200403130015.17674.adasi@kernel.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <200403130015.17674.adasi@kernel.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 13, 2004 at 12:15:17AM +0100, Witold Krecicki wrote:
> When I use alsa snd-powermac driver, the lowest volume setting (but witho=
ut=20
> muting) is at about half of full volume, it's impossible to get any volum=
e=20
> level between mute and vol=3D0. Is that a bug or a feature?

Just a me too
This happens in the change from 2.6.4-rc1 to 2.6.4-rc2
I have checked the changelog and there is no change in the sound section
(perhaps a change in timer.c?)

Best regards

--
Celso Gonzalez

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVJoJW7HC4i2jZ7cRArwAAJ9SjebQ6MmunoOB5dZU3jwY2iJQdACfcSwd
4zm6BH9E66q15KYSGW1P4L4=
=VCkA
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
