Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWD3Ruf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWD3Ruf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWD3Ruf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:50:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751213AbWD3Rue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:50:34 -0400
X-Authenticated: #2308221
Date: Sun, 30 Apr 2006 19:50:31 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Dmitry Fedorov <dm.fedorov@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [FYI] whitespace removal
Message-ID: <20060430175031.GF17917@zeus.uziel.local>
References: <20060430172716.GC17917@zeus.uziel.local> <7115951b0604301036h3962ddbfs5a60c93a130c50a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <7115951b0604301036h3962ddbfs5a60c93a130c50a0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, May 01, 2006 at 12:36:02AM +0700, Dmitry Fedorov wrote:
>=20
> Use "diff -b".

diff -b would be useful to ignore whitespace in comparisons, thanks for
opening my eyes. I doubt it would be useful while creating cleanup
patches, though ; )

Kind regards,
Chris

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRFT4512m8MprmeOlAQLL1hAAqLbduG7WVWzjXRiPCZpuL2B1Kij8/Nxs
BZvxzRpH8he4lps6+69z04WhWSCeNJhwqFeHUYaRY3YveB6AxPexjuVbDcU1cTv4
qOZ2BBYGT1r5ScRGcxW/um9rIevpvv9V0N+W0r1Il5GsQESLZO2Ma2ZPHDEsvWHm
s1HbIZtjaHGXal4J/hpsB/ghbkakUqOVqraBizDYUgLPWmRM3mKfMDGlUG1yZ+BR
7KxS4kSTpt6l3XdZ24nAbajBrAYqXBxHWwL1QndLaZCVqB02FQifA8rqCH1eVtzi
V4Q+G9DWDkc1c6vux2Vyya3zo/FBarQS89hgdm/DwNmTgm/jp7Uii58+dCHAuPR2
Sd5BYRu8a+CHUiXW/I++2U0Uh8Tx0rO+GmiDPcKAJ5kgSs6pFamVwzHBQQX0gFZh
5OzO19C3CbMp0ImXvP93FNKC+OiY+e1dXFaQBqzuh9iP3zGE8bep/sfnCEKYod6x
j7SOrz7Pq6xVxVAWL+bF4WkgM1d39yPYq1mOlFlRyMhsqRB3b9WBtoeg/Z9gaNNF
5+YcXTX6TmOsgrmL9WlqcpFac8bdKFM7mejWzo9U3cohE4agJPz3ZhliH6Tr5AlR
h6ODnwdhFsignntqlHaBzOxszdEOAk4GjM4yuM9zG+XKeMmTDelKuODBeAvCjBUO
9MxQ981hWwc=
=9L7u
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

