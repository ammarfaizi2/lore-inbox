Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTGGQzX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTGGQzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:55:23 -0400
Received: from mailb.telia.com ([194.22.194.6]:35803 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S264491AbTGGQzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:55:22 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
In-Reply-To: <200307071734.01575.schlicht@uni-mannheim.de>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	 <200307071734.01575.schlicht@uni-mannheim.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-holf9TlXk8wASZ0OCRgY"
Organization: LANIL
Message-Id: <1057597773.6857.1.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 07 Jul 2003 19:09:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-holf9TlXk8wASZ0OCRgY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-07 at 17:33, Thomas Schlichter wrote:
> The problem is the highpmd patch in -mm2. There are two options:
> 1. Revert the highpmd patch.
> 2. Apply the attached patch to the NVIDIA kernel module sources.

Thanks alot, applying the patch you supplied cured the problem.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-holf9TlXk8wASZ0OCRgY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CalNyqbmAWw8VdkRAoVnAJ9MS76dMjIi65suY8htmHFfdQUCDwCg3Hp9
fg/uAwzD4lY7PkEVEUOrdDg=
=6DVm
-----END PGP SIGNATURE-----

--=-holf9TlXk8wASZ0OCRgY--

