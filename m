Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVKPQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVKPQNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbVKPQNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:13:11 -0500
Received: from sipsolutions.net ([66.160.135.76]:17414 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1030393AbVKPQNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:13:10 -0500
Subject: Re: PowerBook5,8 - TrackPad update
From: Johannes Berg <johannes@sipsolutions.net>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org
In-Reply-To: <111620051607.26898.437B594B000ACFF200006912220074818400009A9B9CD3040A029D0A05@comcast.net>
References: <111620051607.26898.437B594B000ACFF200006912220074818400009A9B9CD3040A029D0A05@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gz//X/C+kB25KYIyHHFx"
Date: Wed, 16 Nov 2005 17:13:05 +0100
Message-Id: <1132157585.4843.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gz//X/C+kB25KYIyHHFx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-16 at 16:07 +0000, Parag Warudkar wrote:

> Yep the data layout/ordering is cetainly changed. I was thinking of
> writing something to relayfs and then use scripts to parse and
> interpret. But now I think I will be better off using your driver
> +scripts to sample the data. =20

That explains a lot :)
You'll want to start without appletouch then, it only gets in your way
interpreting the data.

relayfs is certainly a better idea then trying to do this via udp or
something as I did first =3D)

Good luck,
johannes

--=-gz//X/C+kB25KYIyHHFx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iD8DBQBDe1qR/ETPhpq3jKURAlGDAKCklTJpUkVRg2QvNZAOIPAxT3VEnwCeJF7g
QkS7QSwBlP+fqvdD7N73b48=
=PgsQ
-----END PGP SIGNATURE-----

--=-gz//X/C+kB25KYIyHHFx--

