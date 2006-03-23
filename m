Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWCWUGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWCWUGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWCWUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:06:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:36801 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422672AbWCWUGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:06:11 -0500
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core
	driver
From: Robert Walsh <rjwalsh@pathscale.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, rdreier@cisco.com,
       openib-general@openib.org
In-Reply-To: <1143103485.6411.14.camel@camp4.serpentine.com>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
	 <20060323054905.GB20672@kroah.com>
	 <1143103485.6411.14.camel@camp4.serpentine.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+fNhQYd/KBLqRFeT4qfR"
Date: Thu, 23 Mar 2006 12:06:10 -0800
Message-Id: <1143144370.32470.0.camel@hematite.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+fNhQYd/KBLqRFeT4qfR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > Oh, and I like your new filesystem, but where do you propose that it be
> > mounted?
>=20
> I don't have any good candidates in mind.  In our development
> environment, we're mounting it in /ipath, but that doesn't seem like a
> good long-term name.  Do you have any suggestions?

Actually, I've been mounting it on /ipathfs.  Not that the difference is
terribly important.  But if you do have suggestions on where this kind
of thing should go, I'd love to hear it.

Regards,
 Robert.

--=20
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.

--=-+fNhQYd/KBLqRFeT4qfR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUARCL/svzvnpzTd9fxAQL3RAf/bEEYicSZ5GVQUEzZ2Yh+9XMlkHiV5G1A
mXRofV7SUNooY0AHefdB4VBEGRHxD4Ucv63eyrITeBswg8ynNFehqN7XGx0G5PjA
dvU6I+W78aIDUicW0s4SBMVDJac9+WWG1/fXrRUY7E1wf11V5tLhNyf6Vj/uwVr9
IXCI9nzNfac1hoVmyxB27aJuGLOuvH1foyvr0xDgS7qiRmklVVolfBrFgGhzKLKy
Y9h57GACUi4gatxMPtMW2WCktdrJW2+Ov+AtTVENIrscmlqo8F3TJEJABclZGEEl
Ui1KOlGFz4Vuk0mI60pszPNZU6kCtMGVa/IrIzlXl6twQnbrzgMuwQ==
=xVPi
-----END PGP SIGNATURE-----

--=-+fNhQYd/KBLqRFeT4qfR--

