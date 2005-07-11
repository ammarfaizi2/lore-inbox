Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVGLB2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVGLB2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGKOHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:07:25 -0400
Received: from nysv.org ([213.157.66.145]:39595 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261779AbVGKOHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:07:17 -0400
Date: Mon, 11 Jul 2005 17:06:28 +0300
To: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Cc: linux-poweredge@dell.com
Subject: Re: USB bugs in 2.6.11.8, 2.6.11.10 and 2.6.12.2
Message-ID: <20050711140628.GL11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nw7Js0ltx4YC415X"
Content-Disposition: inline
In-Reply-To: <20050707133805.GC11013@nysv.org>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nw7Js0ltx4YC415X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Sorry about the bother, enabling K8 IOMMU fixed the issues.
At least that's the most relevant change I made to the conf
to fix it.

For some reason I must have had a brainfart and not enabled it.

Thanks to Pauli Borodulin for noticing this :)

--=20
mjt


--nw7Js0ltx4YC415X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC0nzkIqNMpVm8OhwRAoPMAJsGCvmj7emtlfpMFpNEIjPPevHO0wCgkfHo
OdglKlykvj8NGHDA9O0OQQg=
=wZFZ
-----END PGP SIGNATURE-----

--nw7Js0ltx4YC415X--
