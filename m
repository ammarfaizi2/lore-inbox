Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUHTPGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUHTPGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUHTPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:06:34 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:31903 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268183AbUHTPBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:01:11 -0400
Date: Fri, 20 Aug 2004 17:00:36 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Ram?n Rey Vicente <ramon.rey@hispalinux.es>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Firmware Loader is orphan
Message-ID: <20040820150036.GE16660@thundrix.ch>
References: <ramon.rey@hispalinux.es> <4123F1E6.2080308@hispalinux.es> <200408191558.i7JFwxw0004307@laptop14.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <200408191558.i7JFwxw0004307@laptop14.inf.utfsm.cl>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Aug 19, 2004 at 11:58:59AM -0400, Horst von Brand wrote:
> I's move the data (at least the name) to a THANKS (or some such) file for
> people who left as maintainers (for whatever reason). I think they deserve
> our lasting gratitude.

I think he belongs into CREDITS, just like the late Leonard Zubkoff.

diff -u linux-2.6.8.1/CREDITS~ linux-2.6.8.1/CREDITS
--- linux-2.6.8.1/CREDITS~      2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1/CREDITS       2004-08-20 18:59:27.347605928 +0200
@@ -2838,6 +2838,10 @@
 S: 8006 Zuerich
 S: Switzerland
=20
+N: Manuel Estrada Sainz
+E: ranty@debian.org
+D: Firmware loader (request_firmware)
+
 N: Wayne Salamon
 E: wsalamon@tislabs.com
 E: wsalamon@nai.com

			   Tonnerre

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBJhIT/4bL7ovhw40RApm9AJ972Abi+MXUSa68pXN4iNIHo9TAVwCfUqvm
6T/FLtwnR/JObv1NJ5YdEVo=
=rcod
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
