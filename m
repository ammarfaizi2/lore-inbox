Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUBXCtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUBXCtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:49:51 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:34502 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262137AbUBXCtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:49:49 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Date: Tue, 24 Feb 2004 13:49:42 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devpts_fs.h fails with "error: parameter name omitted"
Message-ID: <20040224024942.GG1200@cse.unsw.EDU.AU>
References: <20040224021651.GF1200@cse.unsw.EDU.AU> <20040224022424.GL31035@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <20040224022424.GL31035@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2004 at 02:24:24AM +0000, viro@parcelfarce.linux.theplanet.=
co.uk wrote:
> That part makes sense.  Previous one doesn't.

Is that by convention or is leaving out the parameter name in the
prototype standardised somewhere? =20

(just curious because Documentation/CodingStyle doesn't mention it)

-i

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAOrvGWDlSU/gp6ecRAkZwAKCfFeCRu6K9AEERqTKNpupvFQ5JvgCePuOh
YZa18/JYknHR7axezdrT3NU=
=M4VD
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
