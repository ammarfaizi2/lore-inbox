Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbULVXFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbULVXFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbULVXFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:05:48 -0500
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:10880 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S262074AbULVXFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:05:42 -0500
Date: Thu, 23 Dec 2004 00:05:34 +0100
From: Kristian Eide <kreide@online.no>
Subject: Re: raid5 crash
In-reply-to: <200412222326.15329.norbert-kernel@edusupport.nl>
To: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Cc: linux-kernel@vger.kernel.org
Message-id: <200412230005.39026.kreide@online.no>
MIME-version: 1.0
Content-type: multipart/signed; boundary=nextPart2268994.x3rluGtbaK;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-transfer-encoding: 7bit
References: <200412222304.36585.kreide@online.no>
 <200412222326.15329.norbert-kernel@edusupport.nl>
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2268994.x3rluGtbaK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> The sii 3114 is a RAID controller by itself.
> Is in not conflicting somewhere (like running software RAID5 and at the
> same time hardware RAID X?)

No. The SiI 3114 is only being used as an SATA controller; I have not=20
configured any hardware raid.

Sincerely,

=2D-=20
Kristian

--nextPart2268994.x3rluGtbaK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBByf3CRBuET7ul/ccRAqOPAJ91fcJf7P1FEImoEFHYtR8Fhf224gCgodoB
Rh2f44qVirz44zhbcBFkwPY=
=yZ61
-----END PGP SIGNATURE-----

--nextPart2268994.x3rluGtbaK--
