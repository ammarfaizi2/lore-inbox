Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUGANGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUGANGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUGANGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:06:52 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:51198 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265075AbUGANGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:06:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: s390(64) per_cpu in modules (ipv6)
Date: Thu, 1 Jul 2004 15:05:55 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com> <20040630135505.5e1fcb4d@lembas.zaitcev.lan>
In-Reply-To: <20040630135505.5e1fcb4d@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_zwA5AB51DxPIcWo";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011505.55842.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_zwA5AB51DxPIcWo
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch, 30. Juni 2004 22:55, Pete Zaitcev wrote:
> What is the minimum gcc version which supports "X" constraint?
>=20
It's already there in 2.95, which was the oldest version with
s390 support.

	Arnd <><

--Boundary-02=_zwA5AB51DxPIcWo
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5Awz5t5GS2LDRf4RAo1BAJ48UM16Pfp67VEjNmvhsN9eqjmpuwCfRYvB
ZaTS/mWNxIaV//3T+ZGG+DI=
=PiPY
-----END PGP SIGNATURE-----

--Boundary-02=_zwA5AB51DxPIcWo--
