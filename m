Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUANM7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUANM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:59:23 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:31874 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261492AbUANM7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:59:21 -0500
Subject: Re: kernel 2.6 install problems
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Ernst, Yehuda" <yernst@ndsisrael.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <31058754212B50469824909BE90A4CFB402EED@ILEX2.IL.NDS.COM>
References: <31058754212B50469824909BE90A4CFB402EED@ILEX2.IL.NDS.COM>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wyc79ddmfz7ndQy5KF60"
Organization: Red Hat, Inc.
Message-Id: <1074085150.4981.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jan 2004 13:59:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wyc79ddmfz7ndQy5KF60
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-14 at 12:38, Ernst, Yehuda wrote:
> hello!
>=20
> I am new here i hope i am in the right place for help.
>=20
> i am trying to install kernel 2.6.1 on Linux red hat for running VLS.
>=20
>=20
> first can some one tell me where to find updated doc's on compiling kerne=
l 2.6
>=20
> after the i finished compiling i run lsmod but no modules are listed
>=20
> also the network is not working and the screen is only 800X600

you will need to update some userspace packages (eg modutils to support
2.6 etc etc)

see http://people.redhat.com/2.5/

--=-wyc79ddmfz7ndQy5KF60
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABT0exULwo51rQBIRAvDdAKCZC1obNeEgCXOjrtRF6smdggRu8wCdEVJf
FmA/eVIehBKIx2iAnAjdJ+4=
=ym7v
-----END PGP SIGNATURE-----

--=-wyc79ddmfz7ndQy5KF60--
