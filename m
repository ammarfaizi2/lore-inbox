Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFJMsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTFJMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 08:48:30 -0400
Received: from [61.95.53.28] ([61.95.53.28]:30471 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S262578AbTFJMs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 08:48:28 -0400
Date: Tue, 10 Jun 2003 23:02:05 +1000
From: Simon Fowler <simon@himi.org>
To: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030610130204.GC27768@himi.org>
Mail-Followup-To: jsimmons@infradead.org,
	linux-kernel@vger.kernel.org
References: <20030610061654.GB25390@himi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20030610061654.GB25390@himi.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> tested is bk as of 2003-06-04). lspci lists this hardware:
>=20
I've narrowed the start of the problem down: 2.5.70-bk13 works,
-bk14 oopses.=20

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5dbMQPlfmRRKmRwRAhcAAKCGOo+/Mj6Mk9NBjj5zv6Qa5AcnfgCfZqI5
QPVUD6iC6TLeh7NKj88p4bo=
=FNv/
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
