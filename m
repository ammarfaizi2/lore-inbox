Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbULWJQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbULWJQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbULWJQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:16:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:10976 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261187AbULWJQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:16:30 -0500
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: on-access events?
Date: Thu, 23 Dec 2004 10:16:16 +0100
User-Agent: KMail/1.6.2
References: <41C9C1C7.6030405@comcast.net>
In-Reply-To: <41C9C1C7.6030405@comcast.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_pzoyBc9RwEHpAgA";
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200412231016.25967.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_pzoyBc9RwEHpAgA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 22. Dezember 2004 19:49, John Richard Moser wrote:
> What kinds of on-access event driving is there for Linux?  I'm=20
looking
> at Dazuko[1] right now, but not sure about what else is out there. =20
I'm
> sure I've seen several; is there anything in the kernel?

Besides the LSM interface in 2.6 kernels there is also the RSBAC=20
framework for 2.4 and 2.6, where you can register from kernel modules=20
at runtime, http://www.rsbac.org.

Dazuko plus caching has also been integrated as RSBAC module.

Amon.
=2D-=20
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22

--Boundary-02=_pzoyBc9RwEHpAgA
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBByozpq9yn6h5RTo8RApPHAJ9evBS7b0ANgnUI8hlkDptaGYC0XACfdkdA
wMclNV7QNNrsx0ucwke4jBY=
=6ArY
-----END PGP SIGNATURE-----

--Boundary-02=_pzoyBc9RwEHpAgA--
