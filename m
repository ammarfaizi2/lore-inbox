Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVKNT3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVKNT3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKNT3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:29:07 -0500
Received: from mout2.freenet.de ([194.97.50.155]:41348 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751255AbVKNT3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:29:06 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 20:28:35 +0100
User-Agent: KMail/1.8.3
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <1131992968.2821.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511141116180.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511141116180.3263@g5.osdl.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200511142028.35448.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart12445492.i1WKZSTkCG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12445492.i1WKZSTkCG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 14 November 2005 20:17, you wrote:
>=20
> On Mon, 14 Nov 2005, Arjan van de Ven wrote:
> >=20
> > there now is a specification for the broadcom wireless, and a driver is
> > being written right now to that specification; and it seems to be
> > getting along quite well (it's not ready for primetime use yet but at
> > least they can send and receive stuff, which is probably the hardest
> > part)
>=20
> Goodie. With Broadcom and Intel on-board, we should have most of the=20
> market covered in wireless, and ndiswrappers really should be less of an=
=20
> argument (it was never an argument for me personally, but for others..).=
=20

I really hope we get this thing usable in a few weeks.
Looks good so far... .

However, I did not test the broadcom driver on 4k-stacks,
as I only have a G4 with a broadcom card. ;) But I do not expect any proble=
ms.

=2D-=20
Greetings Michael.

--nextPart12445492.i1WKZSTkCG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDeOVjlb09HEdWDKgRAutJAJ467uniMAJpP+pfmFMXXEafn1QhdACfeF1z
d1opROgM0UjFBWfgI/1ir88=
=Uggo
-----END PGP SIGNATURE-----

--nextPart12445492.i1WKZSTkCG--
