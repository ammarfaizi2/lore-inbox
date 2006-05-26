Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWEZQb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWEZQb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEZQbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:31:01 -0400
Received: from 203.red-82-159-197.user.auna.net ([82.159.197.203]:6345 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S1751081AbWEZQaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:30:55 -0400
Subject: Re: A couple of oops.
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= <carlos@cmartin.tk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
In-Reply-To: <1148480798.4298.7.camel@kiopa>
References: <1148408930.7726.11.camel@kiopa>
	 <20060523174030.3b52ca71.akpm@osdl.org>  <1148480798.4298.7.camel@kiopa>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JTzFngX6hNtZwtOARZBj"
Date: Fri, 26 May 2006 18:30:53 +0200
Message-Id: <1148661053.10180.4.camel@kiopa.cmartin.tk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JTzFngX6hNtZwtOARZBj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 This seems to have gone as quick as it appeared. I'm currently running
rc5 with three hours of uptime, which is much longer than I ever managed
with the broken kernel.

 It looks like it was due to some miscompilation issue, though it
happened with a clean tree (make mrproper) so it seemed to be a problem
with the kernel.

   cmn
--=20
Carlos Mart=C3=ADn Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |

--=-JTzFngX6hNtZwtOARZBj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEdy09EVXxXOiy6a4RAivhAKCDpcSuO2odZTID5hB7TpiQXlSLFACffFzS
dxFINSyeI8ZruH87dTGrn2s=
=gDJH
-----END PGP SIGNATURE-----

--=-JTzFngX6hNtZwtOARZBj--

