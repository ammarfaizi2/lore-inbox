Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTFMO3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 10:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTFMO3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 10:29:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37001 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265405AbTFMO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 10:29:29 -0400
Date: Fri, 13 Jun 2003 11:42:29 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: Andrew Morton <akpm@digeo.com>
Cc: Andy Pfiffer <andyp@osdl.org>, christophe@saout.de, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
       Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>,
       Max Valdez <maxvalde@fis.unam.mx>
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-ID: <20030613144229.GZ4639@duckman.distro.conectiva>
References: <1052513725.15923.45.camel@andyp.pdx.osdl.net> <1055369326.1158.252.camel@andyp.pdx.osdl.net> <1055373692.16483.8.camel@chtephan.cs.pocnet.net> <1055377253.1222.8.camel@andyp.pdx.osdl.net> <20030611172958.5e4d3500.akpm@digeo.com> <1055438856.1202.6.camel@andyp.pdx.osdl.net> <20030612105347.6ea644b7.akpm@digeo.com> <1055441028.1202.11.camel@andyp.pdx.osdl.net> <1055442331.1225.11.camel@andyp.pdx.osdl.net> <20030613010149.359cb4dd.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nbjgUHX6eyHhY7pW"
Content-Disposition: inline
In-Reply-To: <20030613010149.359cb4dd.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nbjgUHX6eyHhY7pW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2003 at 01:01:49AM -0700, Andrew Morton wrote:
>=20
> This should fix it.
>=20

It worked here. Thanks!

--=20
Eduardo

--nbjgUHX6eyHhY7pW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6eLVcaRJ66w1lWgRAlXmAJ0ab63xObGd6xbVQlXAXez7ZC0hAACbBT4x
c2DYqMZp2YLC32zCaBC7OZA=
=bJu4
-----END PGP SIGNATURE-----

--nbjgUHX6eyHhY7pW--
