Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVBOV3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVBOV3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVBOV3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:29:09 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:46572 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261899AbVBOV27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:28:59 -0500
Subject: Re: [ACPI] Call for help: list of machines with working S3
From: Henrik Brix Andersen <brix@gentoo.org>
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D/qzgXnlZmrfEGwBYxEt"
Organization: Gentoo Linux
Date: Tue, 15 Feb 2005 22:28:52 +0100
Message-Id: <1108502932.29172.5.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D/qzgXnlZmrfEGwBYxEt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2005-02-14 at 22:11 +0100, Pavel Machek wrote:
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.

I have S3 working with 2.6.11-rc4 here:

Model                           hack (or "how to do it")
---------------------------------------------------------------------------=
---
IBM TP X31 / Type 2672-XXH      LCD backlight must be turned off=20
                                manually using radeontool [1]

Sincerely,
Brix

[1]: http://fdd.com/software/radeon/
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-D/qzgXnlZmrfEGwBYxEt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCEmmUv+Q4flTiePgRAsLfAJ4gpmbP+onTyzPrmxe8lHUxSGStcwCeOcH3
WLUGItS94rAX+dyP/+D/jPI=
=HCtK
-----END PGP SIGNATURE-----

--=-D/qzgXnlZmrfEGwBYxEt--

