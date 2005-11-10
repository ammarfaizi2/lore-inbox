Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVKJPyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVKJPyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKJPyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:54:49 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:25251 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751024AbVKJPyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:54:49 -0500
Date: Thu, 10 Nov 2005 15:54:12 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       davej@codemonkey.org.uk, blaisorblade@yahoo.it
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051110155412.GC16994@inskipp.digriz.org.uk>
References: <20051110151111.GA16994@inskipp.digriz.org.uk> <200511110248.58751.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <200511110248.58751.kernel@kolivas.org>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Con,

Con Kolivas <kernel@kolivas.org> [20051111 02:48:57 +1100]:
>
> On Fri, 11 Nov 2005 02:11, Alexander Clouter wrote:
> > The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
> > This removes the sysfs file 'ignore_nice' and in its place creates a
> > 'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes
> > are not counted towards the 'business' caclulation.
>=20
> And just for the last time I'll argue that the default should be 0. I hav=
e yet=20
> to discuss this with any laptop user who thinks that 1 is the correct def=
ault=20
> for ondemand.
>=20
=2E...resubmitting with alternative defaults....

Cheers

Alex

> Regards,
> Con

--=20
 ____________________________________
/ "An ounce of prevention is worth a \
\ pound of purge."                   /
 ------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDc20kNv5Ugh/sRBYRAg70AKCC6WB58+WngA4Fj/GSAPzdY6zGDQCglnNf
cWxXPuMj8q9iV70DOCt2a0o=
=6MoF
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
