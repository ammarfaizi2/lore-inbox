Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTGKOwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTGKOwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:52:24 -0400
Received: from niobium.golden.net ([199.166.210.90]:64455 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S262593AbTGKOwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:52:23 -0400
Date: Fri, 11 Jul 2003 11:05:34 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711150534.GA25731@linux-sh.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2003 at 03:26:19PM +0100, Alan Cox wrote:
> > - 2.5 features support for several new architectures.
> >   - x86-64 (AMD Hammer)
> >   - ppc64
> >   - UML (User mode Linux)
> >     See http://user-mode-linux.sf.net for more information.
> >   - uCLinux: m68k(w/o MMU), h8300 and v850.  sh also added a uCLinux op=
tion.
> > - The 64 bit s390x port got collapsed into a single port, appearing
> >   as a config option in the base s390 arch.
> > - In the opposite direction, arm26 was split out from arm.
>=20
> sh64 ?
>=20
Not merged yet, I'm still doing a number of 2.5 fixups for it locally. It's
already been merged into 2.4 however.


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/DtI91K+teJFxZ9wRAohiAJ9PXW4POCfGIA12toTYRNFMLVoBjwCffLwP
NOwqfqy+xC6D86vSgDaxVCI=
=Ga5I
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
