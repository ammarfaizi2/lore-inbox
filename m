Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTLYWG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbTLYWG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 17:06:58 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:39136 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264372AbTLYWG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 17:06:56 -0500
Subject: Re: Make ppp_async callable from hard interrupt
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031225205917.GA7238@sacarino.pirispons.net>
References: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
	 <20031225100850.GA6629@penguin.localdomain>
	 <20031225022228.69f78d18.akpm@osdl.org>
	 <20031225205917.GA7238@sacarino.pirispons.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vSNN4Kqt8508y2AhjuZr"
Message-Id: <1072390157.7638.103.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Dec 2003 00:09:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vSNN4Kqt8508y2AhjuZr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-25 at 22:59, Kiko Piris wrote:
> On 25/12/2003 at 02:22, Andrew Morton wrote:
>=20
> > (Marcel Sebek) wrote:
>=20
> > >  If this is true, skb will be used uninitialized.
> >=20
> > True.    Here's an updated patch.
>=20

> I _suspect_ (with absolutely no evidence) this was the same problem as
> the ppp oopses pointed by other people with 2.6.0-mm1.
>=20

Yep.  Andrew, the oops's I got that was similar to those of users of
-mm1 is now gone.


Cheers,

--=20
Martin Schlemmer

--=-vSNN4Kqt8508y2AhjuZr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/62ANqburzKaJYLYRAtpWAJ96qpUGXVQEIFOyHP+IHNCFy98eJgCfViM4
m/11nKHTieMT5pRmDO9ZjIw=
=BUXJ
-----END PGP SIGNATURE-----

--=-vSNN4Kqt8508y2AhjuZr--

