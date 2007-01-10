Return-Path: <linux-kernel-owner+w=401wt.eu-S932735AbXAJIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbXAJIYj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 03:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbXAJIYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 03:24:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932735AbXAJIYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 03:24:38 -0500
Message-ID: <45A4A2AD.6010203@redhat.com>
Date: Wed, 10 Jan 2007 00:24:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 3/4] futex_requeue_pi optimization
References: <45A3B330.9000104@bull.net> <45A3C0CF.4020802@bull.net> <45A3C3F1.6020305@redhat.com> <45A4A102.6050006@bull.net>
In-Reply-To: <45A4A102.6050006@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig560F6A431F99D27EF2968415"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig560F6A431F99D27EF2968415
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> I may miss something, but I don't think there is a need for that.

Yes, I know, I was asking about it only for completeness.  Maybe there
will be a reason to have it some day.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig560F6A431F99D27EF2968415
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFpKKu2ijCOnn/RHQRAuUMAJsEDskZ0LiGc99zOXW73k53TDCi0QCfWybD
9NLiwMmp6X/g39TWKLfh5P0=
=wgP8
-----END PGP SIGNATURE-----

--------------enig560F6A431F99D27EF2968415--
