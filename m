Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTFQUwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTFQUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:52:34 -0400
Received: from [4.5.97.206] ([4.5.97.206]:13696 "EHLO gallant")
	by vger.kernel.org with ESMTP id S264953AbTFQUwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:52:33 -0400
Subject: Re: IPSEC problems with GRE. [RESOLVED]
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: James Morris <jmorris@intercode.com.au>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
In-Reply-To: <Mutt.LNX.4.44.0306172117310.14332-100000@excalibur.intercode.com.au>
References: <Mutt.LNX.4.44.0306172117310.14332-100000@excalibur.intercode.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8FGVdmDxp8UcwV5nY5Fv"
Message-Id: <1055880097.1979.3.camel@festa.omgwallhack.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jun 2003 13:01:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8FGVdmDxp8UcwV5nY5Fv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for the help, but the problem wasn't with the tunnel at all. One
of the machines had a bad memory card, and upon changing that the issue
disappeared. All now seems to be working well.

I hadn't noticed the MTU issue before, but thanks for that, too.

--=20
Julian Blake Kongslie <jblake@omgwallhack.org>

--=-8FGVdmDxp8UcwV5nY5Fv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+73Oh+6o3+Z/zOlURAtIZAKCb/MIz/9aoLD1BVMw2tKU56RwqfACgl6Qc
54SAG/n/fAL2EyGldJU97ps=
=FA6F
-----END PGP SIGNATURE-----

--=-8FGVdmDxp8UcwV5nY5Fv--
