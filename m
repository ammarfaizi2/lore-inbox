Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVHDUmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVHDUmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVHDUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:42:28 -0400
Received: from donau.nordija.com ([217.157.49.52]:33955 "EHLO
	donau.nordija.com") by vger.kernel.org with ESMTP id S262629AbVHDUkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:40:21 -0400
Subject: Re: Oops when shutting down laptop
From: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1123187474.3646.2.camel@mindpipe>
References: <1123186901.8831.42.camel@localhost.localdomain>
	 <1123187474.3646.2.camel@mindpipe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tQ5VPoDNUUX2LNCfj+Is"
Date: Thu, 04 Aug 2005 22:40:14 +0200
Message-Id: <1123188014.8831.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tQ5VPoDNUUX2LNCfj+Is
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-04 at 16:31 -0400, Lee Revell wrote:
> On Thu, 2005-08-04 at 22:21 +0200, Kristian Gr=F8nfeldt S=F8rensen wrote:
> > My laptop oops'es in the final phase of shutdown
>=20
> Kernel is tainted due to ndiswrapper being loaded.  Please reproduce
> with a non tainted kernel.

I have tried that, with exactly the same result.

/Kristian

--=-tQ5VPoDNUUX2LNCfj+Is
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8n0ufHDihydQNssRAppQAJ4vnnEVtUYMA8z/quv8el6PsJVnJwCghh8g
mJPsRHKJ9nXc7DsmfYosq5I=
=VVfF
-----END PGP SIGNATURE-----

--=-tQ5VPoDNUUX2LNCfj+Is--

