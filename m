Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTEAUdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTEAUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:33:38 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:50163 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262407AbTEAUdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:33:35 -0400
Subject: Re: kernel BUG at net/socket.c:147
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Michael D. Harnois" <mharnois@cpinternet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1051821220.4440.1.camel@mharnois.mdharnois.net>
References: <1051821220.4440.1.camel@mharnois.mdharnois.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3hYBr5GavMgORpCl9Dnf"
Organization: Red Hat, Inc.
Message-Id: <1051821952.1407.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 01 May 2003 22:45:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3hYBr5GavMgORpCl9Dnf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-01 at 22:33, Michael D. Harnois wrote:
> This is with 2.5.68-bk11 but happened also with bk10.
>=20
> May  1 15:30:20 mharnois kernel: ------------[ cut here ]------------
> May  1 15:30:20 mharnois kernel: kernel BUG at net/socket.c:147!
> May  1 15:30:20 mharnois kernel: invalid operand: 0000 [#1]
> May  1 15:30:20 mharnois kernel: CPU:    0
> May  1 15:30:20 mharnois kernel: EIP:  =20
> 0060:[net_family_get+110/128]    Tainted: PF=20

May  1 15:30:20 mharnois kernel:  <6>note: vmnet-bridge[9886] exited
with preempt_count 2


does it happen without vmware too ?

--=-3hYBr5GavMgORpCl9Dnf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sYeAxULwo51rQBIRAgHLAJ4wublkhJ3erOrG89+RV0lxOb37iACgknqh
oAModnoUjQ2thNmT8YmFe2Y=
=lept
-----END PGP SIGNATURE-----

--=-3hYBr5GavMgORpCl9Dnf--
