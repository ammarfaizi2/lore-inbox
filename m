Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWGSHAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWGSHAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 03:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWGSHAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 03:00:22 -0400
Received: from admingilde.org ([213.95.32.146]:32722 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932413AbWGSHAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 03:00:21 -0400
Date: Wed, 19 Jul 2006 09:00:19 +0200
From: Martin Waitz <tali@admingilde.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/3] kernel-doc: ignore __devinit
Message-ID: <20060719070019.GB30212@admingilde.org>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <44BD5373.20104@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <44BD5373.20104@oracle.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Jul 18, 2006 at 02:32:35PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>=20
> Ignore __devinit in function definitions so that kernel-doc won't
> fail on them.

why would it fall over __devinit?
And shouldn't we add __{dev}?init{data}? while we are at it?

--=20
Martin Waitz

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEvdiDj/Eaxd/oD7IRAlqfAJ90LOp3eB3Gc+cN0Gp19Y2RDpaf/QCfYxLL
8DCrh/bqvCmBx6c0eC1LQ8U=
=vm24
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
