Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTJTNUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTJTNUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:20:04 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:5810 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S262291AbTJTNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:20:00 -0400
Subject: Re: bkcvs and bksvn out of sync (Was: Re: [2.6.0-test7-bk]
	undefined reference to `NEW_TO_OLD_GID')
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@debian.org>
In-Reply-To: <20031020002246.GA14808@ranty.pantax.net>
References: <1065702589.2234.3.camel@debian>
	 <20031020002246.GA14808@ranty.pantax.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T8RfGjg3q78AxQEZ3S0u"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1066655998.1522.7.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 15:19:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T8RfGjg3q78AxQEZ3S0u
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El lun, 20-10-2003 a las 02:22, Manuel Estrada Sainz escribi=F3:

>  Ram=F3n is probably using the bksvn gateway, after investication, it
>  seams that this changeset was not completely commited to bksvn:

Mmm, I think you are right ;), but it seams was two o more patches in
this changeset and all of them related to the new NEW_TO_OLD_GID macro.
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-T8RfGjg3q78AxQEZ3S0u
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/k+D+RGk68b69cdURArtDAJ9ILp5tlUdHBlkjKUjSTXRQjdsMPwCeOFBX
zs3jkzUy4ceXve7v4hmz/jE=
=aYuW
-----END PGP SIGNATURE-----

--=-T8RfGjg3q78AxQEZ3S0u--

