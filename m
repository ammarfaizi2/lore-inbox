Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULNRLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULNRLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULNRLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:11:38 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:35735 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261561AbULNRK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:10:59 -0500
Subject: Re: [openib-general] [PATCH][v3][5/21] Add InfiniBand MAD
	(management datagram) support
From: Tom Duffy <tduffy@sun.com>
To: Roland Dreier <roland@topspin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org
In-Reply-To: <20041213109.3tK6alRLJABxH4bu@topspin.com>
References: <20041213109.3tK6alRLJABxH4bu@topspin.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aj9f13LD17fFv2j3PtcW"
Date: Tue, 14 Dec 2004 09:10:47 -0800
Message-Id: <1103044247.1054.11.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aj9f13LD17fFv2j3PtcW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 at 10:09 -0800, Roland Dreier wrote:
> Add support for handling InfiniBand MADs (management datagrams),
> including sending and receiving MADs as well as passing MADs on to
> local agents.
>=20
> This is required for an SM (subnet manager) to discover and configure
> the host, since the SM's query MADs must be passed to the local SMA
> (subnet management agent).  In addition, this support is used by upper
> level protocols to send queries to and receive responses from the SM.

This one didn't make it to lkml.  I think it was over the size limit.

-tduffy


--=-aj9f13LD17fFv2j3PtcW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBvx6XdY502zjzwbwRAro8AJ94g7HbJShXqtStwRzIshHnoVI5/wCfZJcm
I5NQ3QSnuEV/q3R5FNUVOMs=
=pNmX
-----END PGP SIGNATURE-----

--=-aj9f13LD17fFv2j3PtcW--
