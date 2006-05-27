Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWE0UHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWE0UHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWE0UHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:07:19 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:57298 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S964945AbWE0UHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:07:17 -0400
Subject: Re: [PATCH] make ams work with latest kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stelian Pop <stelian@popies.net>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060526173908.GA3357@ucw.cz>
References: <1148383943.25971.2.camel@johannes>
	 <1148465069.6723.26.camel@localhost.localdomain>
	 <20060526173908.GA3357@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ANRVqCZSfU/zOXn2j/VX"
Date: Sat, 27 May 2006 22:06:54 +0200
Message-Id: <1148760414.16989.59.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ANRVqCZSfU/zOXn2j/VX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:

> > This driver also provides an absolute input class device, allowing
> > the laptop to act as a pinball machine-esque joystick.
>=20
> Is it useful to have /sysfs interface when we already have same data
> available as joystick?

Might be useful if you need to turn off the "joystick" because X gets
confused with it. Other than that, no.

johannes

--=-ANRVqCZSfU/zOXn2j/VX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHixXKVg1VMiehFYAQIt8g/+KTCerGwZtfWmQSywGmf6Iz+kCVPqI9YF
TKPPzv8fsu+Jw5PY4VnuCBEu7szT48hB7nDElJTpk+pgcx85cDlxNxXdZBOy0t5z
oRVx4PRUbMUMNIuQVMiZCVDlmmNRF0NjuoZCoIllqA7kZbnBUXARV+H3mlLoGKu9
9nGUgI8K+qKSanGhnEfzUKliUCYpW8MBMfl5A6nx8ky5ksVlLewUJKYGFeupy3sC
7Tn0seLoAZejDFVUN0Q0HsJ0WH4v6Vxg1F7nb1EzYkynysFvRTzxwGVR2pro3JKW
HsPVNeHeMKtRoNMlx9yP08E3YJzO068aRen2Pf0y7zY6fHYUHNcxGbP3EA6BzdOo
bgyR+6MRW/tCQui1Giw+b0o3KwOjXLWF7nTUUuIF3L+UI3JFCTtxFBabXTtkpq3M
fmqXfnTKnSP1hP+wCjBJmq87/GrFfLiPzHVFol5WaRIFKUvnT8aREknJwEQxRApC
63TxLjlCStiWx9qoFaWBo+nkq3lZkaHaiJgL8eb75h5F4XemQs9g5/PXixmqDkl5
CdUYkAY2WmrFp3Y2trEiaKNKGKPLsc2JtLdmOZvBv0WVI+YqKJcY8psNlpQ/c6uW
gaXBsXKSSd8u/7H/nFgsESMpVX1JB156fEfObYM1DSjWxT21vYd3cuBMCoMCNb2K
bci/E3dpAWQ=
=tvZ2
-----END PGP SIGNATURE-----

--=-ANRVqCZSfU/zOXn2j/VX--

