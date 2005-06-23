Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVFWCHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVFWCHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVFWCGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:06:04 -0400
Received: from 67.Red-80-25-56.pooles.rima-tde.net ([80.25.56.67]:17984 "EHLO
	estila.tuxedo-es.org") by vger.kernel.org with ESMTP
	id S262020AbVFWCEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:04:47 -0400
Subject: Re: [patch 1/1] selinux: minor cleanup in the
	hooks.c:file_map_prot_check() code
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, sds@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0506222150590.10175-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0506222150590.10175-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xQAYimbzXYnVhSTrz9xM"
Date: Thu, 23 Jun 2005 04:04:38 +0200
Message-Id: <1119492278.9254.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xQAYimbzXYnVhSTrz9xM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 22-06-2005 a las 21:55 -0400, James Morris escribi=F3:
> Please send SELinux kernel patches via the maintainers.

It was sent to Stephen during the development of the execstack and
execheap permission checks patches, but it's up to him to decide about
it right now.

Stephen, is it OK for you?

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-xQAYimbzXYnVhSTrz9xM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCuhi2DcEopW8rLewRAh9QAKDEHv2dqUqFwHAFV7oGJek+8ILobwCgyQYZ
iucPUuie8GRZTgyroioTH5k=
=GNDy
-----END PGP SIGNATURE-----

--=-xQAYimbzXYnVhSTrz9xM--
