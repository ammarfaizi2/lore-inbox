Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVAXNMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVAXNMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAXNMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:12:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49281 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261348AbVAXNMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:12:09 -0500
Subject: Re: [-mm patch] fix SuperIO compilation
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050124123448.GA29631@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124122541.GG3515@stusta.de>  <20050124123448.GA29631@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n3+cvQwP14YpuHe+c7gf"
Organization: MIPT
Date: Mon, 24 Jan 2005 16:04:59 +0300
Message-Id: <1106571899.25992.21.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 24 Jan 2005 12:59:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n3+cvQwP14YpuHe+c7gf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-24 at 12:34 +0000, Christoph Hellwig wrote:
> On Mon, Jan 24, 2005 at 01:25:41PM +0100, Adrian Bunk wrote:
> > On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.11-rc1-mm2:
> > >...
> > >  bk-i2c.patch
> > >...
> > >  Latest versions of various bk trees
> > >...
> >=20
> > This causes the following compile error:
>=20
> Where's that code coming from anyone?  Greg seems to be adding tons of no=
t fully
> reviewed stuff lately..

That code was written by me.
Please provide full error output, since it is compiled successfully
here.

Thank you.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-n3+cvQwP14YpuHe+c7gf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9PJ7IKTPhE+8wY0RAq99AJ4wtboM/6Vk7KYc+3ugu3WmMkVFJwCglxTP
pEKB2AHW8qbYTCPcJUDg4LY=
=OLdY
-----END PGP SIGNATURE-----

--=-n3+cvQwP14YpuHe+c7gf--

