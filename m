Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUHGPd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUHGPd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUHGPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:33:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261951AbUHGPdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:33:24 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091890845.1727.29.camel@mulgrave>
References: <200408051348.i75DmlGD004576@burner.fokus.fraunhofer.de>
	 <20040805150032.GF12483@suse.de>  <1091890845.1727.29.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jd3JznO9jIjjOqzspUIA"
Organization: Red Hat UK
Message-Id: <1091892791.2794.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 17:33:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jd3JznO9jIjjOqzspUIA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> 2.6 has just gone out to a wider audience via SLES9.  As is inevitable,
> the test cases people have in the field are wider than those we
> necessarily have the hw to produce, so it's expected that the arrival
> rate for bugs will increase.
>=20
> The only comparitive metric I have shows me that 2.4 was orders of
> magnitude worse at this point (which was earlier: 2.4.2 from redhat).

It's not quite fair to compare RHL to SLES; RHEL and SLES are
comparable, just like SuSE linux 9.1 and Fedora Core 2 are...


--=-jd3JznO9jIjjOqzspUIA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFPY2xULwo51rQBIRAj/yAJsHOVAoWtXuw+tszoKzsUur/MuN5ACfaaFl
FzYaK9QafFeKEKfapzGQc3E=
=OXky
-----END PGP SIGNATURE-----

--=-jd3JznO9jIjjOqzspUIA--

