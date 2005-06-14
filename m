Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFNSV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFNSV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVFNSVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:21:54 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:17832 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261281AbVFNSVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:21:30 -0400
Subject: RE: [discuss] [OOPS] powernow on smp dual core amd64
From: Tom Duffy <tduffy@sun.com>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com>
References: <84EA05E2CA77634C82730353CBE3A84301CFC14D@SAUSEXMB1.amd.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ikGOA4Iac1F8cAtlpmxo"
Date: Tue, 14 Jun 2005 11:19:23 -0700
Message-Id: <1118773163.22484.13.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ikGOA4Iac1F8cAtlpmxo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-13 at 17:44 -0500, Langsdorf, Mark wrote:
> > > Tom, could you try this patch and see if it helps?
> >=20
> > Yes!  It fixed the panic.  I get much further.
>=20
> Great, I'll test that some more then submit it.

I would like it if this patch could make it into 2.6.12 before it is
released.

Any possibility?

Thanks,

-tduffy

--=-ikGOA4Iac1F8cAtlpmxo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrx+rdY502zjzwbwRAmgFAJ4qiWkq7a2m0IUTiIJw3I7r8J8qcwCfUBhH
LA5I1veQcsD1iTV1MYThg/A=
=xIw8
-----END PGP SIGNATURE-----

--=-ikGOA4Iac1F8cAtlpmxo--
