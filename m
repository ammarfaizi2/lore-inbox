Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVEMFvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVEMFvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 01:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVEMFvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 01:51:42 -0400
Received: from dio.mail.t-online.hu ([195.228.240.89]:55763 "EHLO
	dio.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S262253AbVEMFvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 01:51:39 -0400
Subject: Hyper-Threading Vulnerability
From: Gabor MICSKO <gmicsko@szintezis.hu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GQXYYQD4LSzG/2lDNhBj"
Date: Fri, 13 May 2005 07:51:20 +0200
Message-Id: <1115963481.1723.3.camel@alderaan.trey.hu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-VBMilter: scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GQXYYQD4LSzG/2lDNhBj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

=46rom http://kerneltrap.org/node/5103

``Hyper-Threading, as currently implemented on Intel Pentium Extreme
Edition, Pentium 4, Mobile Pentium 4, and Xeon processors, suffers from
a serious security flaw," Colin explains. "This flaw permits local
information disclosure, including allowing an unprivileged user to steal
an RSA private key being used on the same machine. Administrators of
multi-user systems are strongly advised to take action to disable
Hyper-Threading immediately."

``More'' info here:
http://www.daemonology.net/hyperthreading-considered-harmful/

Is this flaw affects the current stable Linux kernels? Workaround?
Patch?

Thanks.

-
MG

--=-GQXYYQD4LSzG/2lDNhBj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ez az =?ISO-8859-1?Q?=FCzenetr=E9sz?=
	=?ISO-8859-1?Q?_digit=E1lis?= =?ISO-8859-1?Q?_al=E1=EDr=E1ssal?= van
	=?ISO-8859-1?Q?ell=E1tva?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBChEBYo75Oas+VX1ARAtNaAJ9Ld/EsVKjh9Ayi10NgjDF22zFnywCgoCNy
JFtWXFWAEa3Gs5qZkq2JvPo=
=45Sy
-----END PGP SIGNATURE-----

--=-GQXYYQD4LSzG/2lDNhBj--

