Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269824AbUIDGws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269824AbUIDGws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbUIDGwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:52:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269824AbUIDGv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:51:58 -0400
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL
	functions.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: dcn@sgi.com
In-Reply-To: <200409032207.i83M7CKj015068@hera.kernel.org>
References: <200409032207.i83M7CKj015068@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oVpllR8NkDjT82+yN3Xd"
Organization: Red Hat UK
Message-Id: <1094280707.2801.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 08:51:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oVpllR8NkDjT82+yN3Xd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-25 at 20:27, Linux Kernel Mailing List wrote:
> ChangeSet 1.1803.128.1, 2004/08/25 18:27:33+00:00, dcn@sgi.com
>=20
> 	[IA64] allow OEM written modules to make calls to ia64 OEM SAL functions=
.
> =09
> 	Add wrapper functions for SAL_CALL(), SAL_CALL_NOLOCK(), and
> 	SAL_CALL_REENTRANT() that allow OEM written modules to make
> 	calls to ia64 OEM SAL functions.
> =09

are there any such modules? Are they GPL licensed or all proprietary ?

--=-oVpllR8NkDjT82+yN3Xd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOWYDxULwo51rQBIRAv+QAJ9H9kFo8Ral8RdJ8oLaRFkxkDOw+ACgmLXd
Vi1laELlGerW2ebZG7uPR3M=
=4nEr
-----END PGP SIGNATURE-----

--=-oVpllR8NkDjT82+yN3Xd--

