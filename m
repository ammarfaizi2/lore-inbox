Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUHBEU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUHBEU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHBEU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:20:27 -0400
Received: from [202.157.148.44] ([202.157.148.44]:29401 "EHLO
	apollo.dmz1.securecirt.com") by vger.kernel.org with ESMTP
	id S266250AbUHBEUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:20:21 -0400
Subject: Re: Possible XFS Corruption
From: Callan Tham <callan.tham@securecirt.com>
Reply-To: callan.tham@securecirt.com
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040802050232.GB21646@frodo>
References: <1091418545.6750.12.camel@taz.lan.securecirt.com>
	 <20040802050232.GB21646@frodo>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jIrcf31R6MJQTGOwZqlN"
Organization: SecureCiRT Pte Ltd
Message-Id: <1091420414.7363.17.camel@taz.lan.securecirt.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 12:20:14 +0800
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.721, required 3,
	autolearn=not spam, AWL 2.18, BAYES_00 -4.90)
X-MailScanner-Envelope-From: callan.tham@securecirt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jIrcf31R6MJQTGOwZqlN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-02 at 13:02, Nathan Scott wrote:
> > I'm running a Gentoo-patched 2.6.7 kernel, and am experiencing possible
> > XFS corruption on one of my partitions. I've included a sample of the
>=20
> Is it reproducible with an unpatched kernel.org kernel?
>=20
> thanks.

Hi Nathan,

Unfortunately, I am unable to test this with a vanilla kernel. However,
looking through the Gentoo patches, they did not touch any of the XFS
code in a vanilla 2.6.7 kernel.

Is there any other way to diagnose this?

Thank you,

Callan

--=-jIrcf31R6MJQTGOwZqlN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBDcD+L0kD4kWwAZQRAojuAKCp4zyYvKMMLN7fRwt2ltXqSLftvACgkUQp
yII0Bg8naJsP/tju3etexb4=
=bLYS
-----END PGP SIGNATURE-----

--=-jIrcf31R6MJQTGOwZqlN--

