Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTIIXOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbTIIXOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:14:12 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:1248
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265116AbTIIXOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:14:03 -0400
Date: Tue, 9 Sep 2003 16:14:02 -0700
To: Jan Ischebeck <mail@jan-ischebeck.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030909231402.GG7314@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Jan Ischebeck <mail@jan-ischebeck.de>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1063138439.2168.34.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <1063138439.2168.34.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2003 at 10:14:00PM +0200, Jan Ischebeck wrote:
> make[2]: *** [mm/slab.o] Fehler 1
> make[1]: *** [mm] Fehler 2
> make: *** [stamp-build] Fehler 2

Try the patch I recently posted to the list Re: the original message.

--=20
Joshua Kwan

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iQIVAwUBP15euKOILr94RG8mAQIk6hAA4ZRrQjDWtSD3U0eyYa9IttbNi5fZu6pH
G4Yh4jkCz3K9BSoE0XM20zw+U1uE9qPy8N2sA301KJlOYZLRvA9Y7IFvDILldpCh
Y0NhFGssuR7zR+XgW3QUzcY38N0SUKfAaEV8IOdYy1U3amsPF7e6aL5DVwp+06I/
4+yXuKAM4dJ/CH2NYQnh/9Ex/voHwHRv5uC5KbFVLjYrPafGidGDnqql7Yare/Ys
ae9cqmawteeyUvHFXAK/ZpJzMXbbBGo/xZO3ktYGvgCQ/5gvCX8KExu8N5iFPwds
z18+mCDwh5O15gcQZbCwYK4esyEhB12UqZntL2YwEMX9gw9pF9rT4c+vuBrScoTF
FqW5yIyaysSjb8G+2dZ1rAmHcGFoft3I39O4RDRQuBPTt1cx7ZKYF7qIjRDDHxHz
uFEHsxK0n9irjrkD687bx84+gyh1AxjStZOnBSb5SPWBIV0s46PQJ87eY3uKyVvf
BFF0YYqGYj4iaGSPmWRJG9E7gsEfEyDOaxInr7zZ9lfqRxBvZGOgQqeotAjMrc0u
ijgV/0ejj15QI2mwkSsMX/JqY6qvAgnV7XYXD1Xhr6jwX4DDrmj+63R7ZlvyLrKc
a/9sEr7Jp2wcK5hTeB7CbbCDmoW3Ee/IjVJoV02UP1sAboJmmgMs22aroeniki+a
FBTUJvdIOU4=
=y8gK
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
