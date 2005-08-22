Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVHVWe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVHVWe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVHVWey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53386 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751479AbVHVWeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:31 -0400
Date: Mon, 22 Aug 2005 09:45:18 +0200
From: Martin Waitz <tali@admingilde.org>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Pekka Enberg <penberg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Documentation] Use doxygen or another tool to generate a documentation ?
Message-ID: <20050822074518.GF9530@admingilde.org>
Mail-Followup-To: Stephane Wirtel <stephane.wirtel@belgacom.net>,
	Sam Ravnborg <sam@ravnborg.org>, Pekka Enberg <penberg@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050819213447.GA9538@localhost.localdomain> <84144f02050819144660238be4@mail.gmail.com> <20050819232340.GB9538@localhost.localdomain> <20050820074106.GA15162@mars.ravnborg.org> <20050820091941.GA15936@localhost.localdomain> <20050820173706.GA11079@mars.ravnborg.org> <20050821151231.GE9530@admingilde.org> <20050821183242.GA18020@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <20050821183242.GA18020@localhost.localdomain>
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


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Aug 21, 2005 at 08:32:42PM +0200, Stephane Wirtel wrote:
> Martin, your patch works for the htmldocs target, but not for the
> pdfdocs, I think there is a bug in a latex package. I don't know which
> one, but it's the same error.

yes, some pdfdocs are broken and I haven't found the cause yet.
I guess we have to ditch xmlto, at least for PDF/PS.

--=20
Martin Waitz

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCYKOj/Eaxd/oD7IRAkcDAJ9PkuM6y+5Q7dfEWfJJr1f7wPteYQCfV/LV
phQAxr5cDAkuffzTaMPUSeU=
=hDdJ
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
