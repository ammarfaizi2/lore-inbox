Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWHMCTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWHMCTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 22:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWHMCTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 22:19:40 -0400
Received: from lug-owl.de ([195.71.106.12]:34487 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932650AbWHMCTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 22:19:40 -0400
Date: Sun, 13 Aug 2006 04:19:38 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Ian E. Morgan" <imorgan@webcon.ca>
Subject: Re: Neverending module_param() bugs
Message-ID: <20060813021938.GN2323@lug-owl.de>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Ian E. Morgan" <imorgan@webcon.ca>
References: <20060812214709.GC6252@martell.zuzino.mipt.ru> <1155430441.3941.35.camel@praia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGLW8NzjjVmDHwQh"
Content-Disposition: inline
In-Reply-To: <1155430441.3941.35.camel@praia>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eGLW8NzjjVmDHwQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-08-12 21:54:01 -0300, Mauro Carvalho Chehab <mchehab@infradead=
=2Eorg> wrote:
> Em Dom, 2006-08-13 =C3=A0s 01:47 +0400, Alexey Dobriyan escreveu:
> > P.S.: drivers/media/video/tuner-simple.c:13:module_param(offset, int,
> > 0666);
>=20
> Good catch. We should change it to 0x664. I'll prepare such patch.

But keep in mind it's really octal, not hex.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                   ...und wenn Du denkst, es geht nicht mehr,
the second  :                          kommt irgendwo ein Lichtlein her.

--eGLW8NzjjVmDHwQh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE3ow6Hb1edYOZ4bsRAk/XAJ4wcr7sv45Ytd/iRbRqPY4/KMC7rACfThEu
VPjf0ypFkhA8ogTQ/7eDrF8=
=yMVZ
-----END PGP SIGNATURE-----

--eGLW8NzjjVmDHwQh--
