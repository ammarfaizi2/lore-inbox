Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLWPit (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTLWPis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:38:48 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:57473 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261605AbTLWPir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:38:47 -0500
Subject: Re: Question on LFS in Redhat
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031223151042.GE9089@vnl.com>
References: <20031223151042.GE9089@vnl.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yT6xnuAg4DKgnaZ7EKh/"
Organization: Red Hat, Inc.
Message-Id: <1072193917.5262.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Dec 2003 16:38:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yT6xnuAg4DKgnaZ7EKh/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-23 at 16:10, Dale Amon wrote:
> If there are any Redhat folk around... could you tell
> me if you've included the LFS patches in your:
>=20
> 	2.4.16-9smp

Red Hat never released a 2.4.16 kernel for production use.

However we also never released a 2.4 kernel with the large BLOCK patch.
All 2.4 kernels we shipped can do files > 2 Gb of course.

--=-yT6xnuAg4DKgnaZ7EKh/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6GF9xULwo51rQBIRAkwsAJ48Z/z2dhuf7pbPynZPIumiKiTucQCfTGIM
W7CK35MJRuSkqaPc9tR565s=
=sdjz
-----END PGP SIGNATURE-----

--=-yT6xnuAg4DKgnaZ7EKh/--
