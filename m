Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTFRFBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 01:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTFRFBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 01:01:13 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:10629 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S265074AbTFRFBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 01:01:12 -0400
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
From: Anders Karlsson <anders@trudheim.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
References: <3EE66C86.8090708@free.fr>
	 <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a5DSGvvutvvtz+YXoSjG"
Organization: Trudheim Technology Limited
Message-Id: <1055913307.2436.27.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 18 Jun 2003 06:15:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a5DSGvvutvvtz+YXoSjG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-18 at 00:25, Marcelo Tosatti wrote:
> My plan for 2.4.22 is:
>=20
>  - Include the new aic7xxx driver.
>  - Include ACPI. (I now realized its importance). Already discussing with
>    Andrew the best way to do it.
>  - Fix the latency/interactivity problems (Chris, Nick and Andrea working
> on that)
>  - Merge obviously correct -aa VM patches.
>=20
> Those are the most important things that are needed now, I think.

How about the backported cpufreq patch from Bill Nottingham? Can that
one go in as well please? It is not a big patch as such and it is
working as far as I can tell. I have been running it since it was posted
on the list last week.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-a5DSGvvutvvtz+YXoSjG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+7/VbLYywqksgYBoRAuPfAJ9X/dIYfARAlY6rDg9dPuptBhaB2wCghdQc
PClgX3/l1+L/BYp+nMfoFv0=
=yZuv
-----END PGP SIGNATURE-----

--=-a5DSGvvutvvtz+YXoSjG--

