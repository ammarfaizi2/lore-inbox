Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270504AbTGSG7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 02:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbTGSG7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 02:59:42 -0400
Received: from gate.in-addr.de ([212.8.193.158]:34704 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S270504AbTGSG7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 02:59:41 -0400
Date: Sat, 19 Jul 2003 09:06:20 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andre Tomt <andre@tomt.net>, Mike Fedyk <mfedyk@matchmail.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030719070620.GB11510@marowsky-bree.de>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva> <1058569601.544.1.camel@teapot.felipe-alfaro.com> <20030719003824.GI2289@matchmail.com> <1058575991.3407.117.camel@slurv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <1058575991.3407.117.camel@slurv>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-07-19T02:53:11, Andre Tomt <andre@tomt.net> said:

> > So, is acl only working with ext[23] & XFS?  What about reiserfs or jfs?
> There is one patch floating around for reiserfs, but thats probably
> _very_ unofficial code. JFS, no idea.

SuSE has been shipping with ACLs in ext[23], XFS, reiserfs, JFS for
almost a year now. Andreas Gruenbacher did a lot of work on it.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
SuSE Labs - Research & Development, SuSE Linux AG
 =20
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/GO3rudf3XQV4S2cRArwQAJ9rTjTJ86Yp+eP/pPxeubuwXnXeQQCcCD2T
r+TF2lfu/mTdrMtW/lJyPpU=
=fp4H
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
