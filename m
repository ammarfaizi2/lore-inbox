Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUHCTFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUHCTFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUHCTFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:05:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58087 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266802AbUHCTFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:05:14 -0400
Subject: Re: modversion.h in kernel 2.6.x
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Lei Yang <leiyang@nec-labs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>
In-Reply-To: <1091570120.5487.82.camel@bijar.nec-labs.com>
References: <1091570120.5487.82.camel@bijar.nec-labs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SG7df+OaYzqq8ThEpgMj"
Organization: Red Hat UK
Message-Id: <1091559899.2816.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 21:05:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SG7df+OaYzqq8ThEpgMj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-03 at 23:55, Lei Yang wrote:
> Hello,
>=20
> Could anyone tell me what happened with modversion.h in 2.6.x? I want to
> build a module whose makefile indicates that,

this module has a broken makefile for 2.6 .....

it really should use the kbuild infrastructure instead.

--=-SG7df+OaYzqq8ThEpgMj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBD+HbxULwo51rQBIRAnhZAJ9P7skqX0CujrpKoKfvnpAkXN+ZAACfdphs
xtSd3TvVHYqPb5UgI3yakn0=
=0YXb
-----END PGP SIGNATURE-----

--=-SG7df+OaYzqq8ThEpgMj--

