Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUEYHHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUEYHHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUEYHG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:06:59 -0400
Received: from mx2.redhat.com ([66.187.237.31]:31646 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264782AbUEYHG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:06:58 -0400
Subject: Re: [RFD] Explicitly documenting patch submission
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-witUPoUjtno+OXyIUCOE"
Organization: Red Hat UK
Message-Id: <1085468812.2783.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 May 2004 09:06:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-witUPoUjtno+OXyIUCOE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> explanation part of the patch. That sign-off would be just a single line=20
> at the end (possibly after _other_ peoples sign-offs), saying:
>=20
> 	Signed-off-by: Random J Developer <random@developer.org>

well this obviously needs to include that you signed off on the DCO and
not some other random piece of paper, and it probably should include the
DCO revision number you signed off on.
Without the former the Signed-off-by: line is entirely empty afaics,
without the later we're not future proof.


--=-witUPoUjtno+OXyIUCOE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsvCMxULwo51rQBIRAq+5AJ0cRLGIiIr6SAO4C4XvY/j6gg7o7wCfU1/P
Q2PFizsRETmLZ7gCl/tPquY=
=ZvSe
-----END PGP SIGNATURE-----

--=-witUPoUjtno+OXyIUCOE--

