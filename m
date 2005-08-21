Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVHUPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVHUPMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVHUPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 11:12:36 -0400
Received: from admingilde.org ([213.95.32.146]:6563 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751049AbVHUPMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 11:12:36 -0400
Date: Sun, 21 Aug 2005 17:12:31 +0200
From: Martin Waitz <tali@admingilde.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Message-ID: <20050821151231.GE9530@admingilde.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Stephane Wirtel <stephane.wirtel@belgacom.net>,
	Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org
References: <20050819213447.GA9538@localhost.localdomain> <84144f02050819144660238be4@mail.gmail.com> <20050819232340.GB9538@localhost.localdomain> <20050820074106.GA15162@mars.ravnborg.org> <20050820091941.GA15936@localhost.localdomain> <20050820173706.GA11079@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20050820173706.GA11079@mars.ravnborg.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Aug 20, 2005 at 07:37:06PM +0200, Sam Ravnborg wrote:
> > In make_docs.log.tar.bz2, you can find log files from make htmldocs,
> > make psdocs and make pdfdocs.
>=20
> From your log-files I could not see what went wrong. It seems to be
> error in the generated files.

kerneldoc could not understand a macro definition.

please try
http://tali.admingilde.org/patches/linux-docbook/docbook-fixes.patch

--=20
Martin Waitz

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCJnfj/Eaxd/oD7IRAv1vAJ9ChYXOdAcJLHR1pOtqWo5MoGxy3QCdGkNo
cmWf/HdkqUP1EJPpBuhlCsE=
=5Rza
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
