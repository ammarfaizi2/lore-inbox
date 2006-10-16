Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWJPKZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWJPKZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWJPKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:25:21 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:49799 "EHLO
	mail-in-11.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030357AbWJPKZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:25:20 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: Is there a way to limit VFAT allocation?
Date: Mon, 16 Oct 2006 12:25:33 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <4533598A.3040909@dunaweb.hu>
In-Reply-To: <4533598A.3040909@dunaweb.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1220996.Vvagx8KeYb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610161225.33190.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1220996.Vvagx8KeYb
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 16 Oktober 2006 12:06 schrieb Zoltan Boszormenyi:
> Is there a way to tell the VFAT driver to exclude
> the last N sectors from the allocation strategy?

Can't you mark that clusters as bad with a diskeditor?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1220996.Vvagx8KeYb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFM14dxU2n/+9+t5gRApieAJ9MW0Yh32UtGSwCKsrYBW97SfC8DQCg1kGP
yJfWWfJ/WWQ01EGWkTExApw=
=PqEz
-----END PGP SIGNATURE-----

--nextPart1220996.Vvagx8KeYb--
