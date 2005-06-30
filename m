Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVF3KRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVF3KRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVF3KRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:17:33 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:24255 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262928AbVF3KRI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:17:08 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: "PPC64-dev" <linuxppc64-dev@ozlabs.org>, netdev@oss.sgi.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: [RFC/PATCH 0/12] Updates & bug fixes for iseries_veth network driver
Date: Thu, 30 Jun 2005 20:16:49 +1000
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1509026.vOgD9QmspS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506302016.55125.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1509026.vOgD9QmspS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi y'all,

The following is a series of patches for the iseries_veth driver.

They're not ready for merging yet, as we need to do more extensive testing.=
=20
However any feedback you have will be greatly appreciated.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1509026.vOgD9QmspS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCw8aXdSjSd0sB4dIRAkhxAKCQId0wJxv/bZLgOoEifQMR5AkmOgCeJIUu
dQ6d0lmlSZwBL6ipT6dw0WU=
=8omQ
-----END PGP SIGNATURE-----

--nextPart1509026.vOgD9QmspS--
