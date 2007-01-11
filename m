Return-Path: <linux-kernel-owner+w=401wt.eu-S965320AbXAKHYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbXAKHYZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbXAKHYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:24:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965320AbXAKHYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:24:24 -0500
Message-ID: <45A5E558.6000807@redhat.com>
Date: Wed, 10 Jan 2007 23:20:56 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net> <45A3C2CE.7070500@redhat.com> <45A4D249.8080904@bull.net>
In-Reply-To: <45A4D249.8080904@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5F3D18B7B74BCAC1644296C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F3D18B7B74BCAC1644296C8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> Here are the average latencies after 5000 measures.
> [...]

Use something more realistic.  I suggest using the Volano benchmark
under your favorite JVM.  I found it to be quite representative and you
get a nice number you can show.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig5F3D18B7B74BCAC1644296C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFpeVY2ijCOnn/RHQRAtg7AJ9ys4FpD+QlWhbV78sfKaNRdMUMcgCgxzaW
KuiplP6nrxGR3u2TwlmYDWM=
=DEVO
-----END PGP SIGNATURE-----

--------------enig5F3D18B7B74BCAC1644296C8--
