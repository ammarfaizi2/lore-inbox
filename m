Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbTLZBpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTLZBpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:45:33 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:21206
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264441AbTLZBpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:45:31 -0500
Date: Thu, 25 Dec 2003 17:45:27 -0800
To: linux-kernel@vger.kernel.org
Cc: Dale Amon <amon@vnl.com>
Subject: Re: 2.6.0 compile failure
Message-ID: <20031226014527.GA12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel@vger.kernel.org, Dale Amon <amon@vnl.com>
References: <20031226010204.GM4987@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20031226010204.GM4987@vnl.com>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 01:02:04AM +0000, Dale Amon wrote:
> {standard input}:12164: Error: invalid character '_' in mnemonic
> Internal error: Terminated (program cc1)
> Please submit a full bug report.
> See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> For Debian GNU/Linux specific bugs,
> please see /usr/share/doc/debian/bug-reporting.txt.

This is obviously a compiler bug. Myself, I've not been able to hit it.
What GCC version are you using? I also use Debian:

$ gcc -v
[...]
gcc version 3.3.3 20031206 (prerelease) (Debian)

--=20
Joshua Kwan

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+uStaOILr94RG8mAQIsnA/+KKKwd26I/U1YGZHSeUmQlo45vdLJlVZz
Jk20dEmbwHDXFRVETFnSZlS3HbWAcb3GsBAn7j8aG5Eq1CbMgsfIFV4dL6vLY+Bh
2eYn7BHpI4p3P3jJ0LiwgEpwrPABYTlgu+lBnnGh2Yp5nfMCMs+vIPlJLqWTgXr0
10TQi5P4k+k6z8cobhAH5wEgPihzouIjLkS4ngwEJeP39rZGATN/fG1QH4ukX25m
/cxXzhHbrZzc10bNcuJGrzBj5o0E5Z/y3zM9P3/vPTjV/9EpjUzAojCvvFbxSX5f
ZB84Cz3bZCHxguI181IJKOIxGXVnDSPSxoM0DXtHbj9dScNZ6hb3Um+1/j3gxMx7
SmRCZVR3BkK4E4m/FtbAYJ9TfJe0+hx1vvWzWxhLvcvEneJvnulrbzxUP3trg7QI
+SVmIwmN3QHde4wuhIutm1L03+H/Pjnv2QRUnB5rPV23OFjLwlOqxytHYpZtXqDN
ZaNiUONSrJNNRNGGeY64KyohBtDrVQoULAp6r5xD7oT1JB7HghMLltalzsEdtGUw
M96tVRL8+hXq1LfxoYJ0/fRjXz/Zjg+0eR4sDxPtptpRG3XgmADVaip0C6Pat4oe
7OdrtsS3lPPfKgwC5sHWlwYlT8qmvL0YQoxKC76rDXsYRDV2z4wgyIH9xo1Lsxdq
Z9gmQngS4hA=
=qqqI
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
