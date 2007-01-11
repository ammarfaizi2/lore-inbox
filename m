Return-Path: <linux-kernel-owner+w=401wt.eu-S1751073AbXAKRsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXAKRsK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbXAKRsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:48:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39822 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbXAKRsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:48:08 -0500
Message-ID: <45A67830.4050207@redhat.com>
Date: Thu, 11 Jan 2007 09:47:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net>
In-Reply-To: <45A3BFAC.1030700@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC7F47141DEB34FFF898557E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC7F47141DEB34FFF898557E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andrew,

if the patches allow this, I'd like to see parts 2, 3, and 4 to be in
-mm ASAP.  Especially the 64-bit variants are urgently needed.  Just
hold off adding the plist use, I am still not convinced that
unconditional use is a good thing, especially with one single global list=
=2E

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigBC7F47141DEB34FFF898557E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFpngw2ijCOnn/RHQRAqsDAKC4HxNAVVwywwJM30OfJ6IKcG22QgCgszOH
HricNTNs9JYiPUx7OtZknho=
=B5//
-----END PGP SIGNATURE-----

--------------enigBC7F47141DEB34FFF898557E--
