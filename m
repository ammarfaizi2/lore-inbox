Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWBZCZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBZCZi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWBZCZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:25:38 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:19160 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751172AbWBZCZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:25:37 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Wolfgang Hoffmann <woho@woho.de>, Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <4400FC28.1060705@gmx.net>
References: <4400FC28.1060705@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kBTnxv2R3TdkpzmmWEAp"
Date: Sun, 26 Feb 2006 03:25:51 +0100
Message-Id: <1140920751.24553.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kBTnxv2R3TdkpzmmWEAp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-26 at 01:54 +0100, Carl-Daniel Hailfinger wrote:
> Hi Jeff,
>=20
> you may want to push this patch into 2.6.16. The version it reverts to
> has been running stable for over four weeks for various folks (CC'ed)
> and we have had no success communicating with the maintainer.

I don't think that this is constructive, the error must be locatable on
later versions, just reverting to a older version of the driver as a cop
out solves nothing... And it also means that we don't understand WHY it
breaks at all.

It would be much better if more ppl could hack the driver source, esp if
they themselves have a system that shows the breakage.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-kBTnxv2R3TdkpzmmWEAp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQBEARGv7F3Euyc51N8RAvTbAJ4u5T/BEpNAHQeJ23Vf2AOEMwupUQCeKlJD
KKEimK4Dht0xyFQ2LUVIWVA=
=bmrT
-----END PGP SIGNATURE-----

--=-kBTnxv2R3TdkpzmmWEAp--

