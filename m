Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTKESiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTKESiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:38:22 -0500
Received: from maximus.kcore.de ([213.133.102.235]:18474 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S263098AbTKESiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:38:19 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: kernel nfsd + user id mapping
Date: Wed, 5 Nov 2003 19:37:38 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5NUq//fOOQ1VdHG";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200311051937.45388.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5NUq//fOOQ1VdHG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,

I'm looking for a method to map user ids on the nfs server. I need to setup=
=20
nfsd to work in a mixed environment Linux server + Linux and Mac OS X=20
clients. NFSv3 will be used.

Does the kernel nfsd support user id mapping? If yes, what do I need to get=
 it=20
to work? The only way to map user ids I found is to use the user space nfsd=
,=20
but it hasn't been updates in ages and doesn't support v3 afaik.

Any pointers would be greatly appreciated.

Bye,
Oliver

=2D-=20
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

--Boundary-02=_5NUq//fOOQ1VdHG
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/qUN5OpifZVYdT9IRAmYPAJ0XI/eThbZwUlj5sXyrEs60kkIVJACgtxJO
rSj92YYnJqIR2Uy5NdvFIlI=
=SH4t
-----END PGP SIGNATURE-----

--Boundary-02=_5NUq//fOOQ1VdHG--

