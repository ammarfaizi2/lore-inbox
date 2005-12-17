Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVLQANF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVLQANF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbVLQANF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:13:05 -0500
Received: from smtp05.auna.com ([62.81.186.15]:51951 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S964822AbVLQANB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:13:01 -0500
Date: Sat, 17 Dec 2005 01:15:24 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
Message-ID: <20051217011524.6d4a1caa@werewolf.auna.net>
In-Reply-To: <20051216231752.GA2731@kroah.com>
References: <20051214234016.0112a86e.akpm@osdl.org>
	<20051216231752.GA2731@kroah.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs93 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_Ci9t3qeicQvxJfbYCqb7dPu;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Sat, 17 Dec 2005 01:12:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_Ci9t3qeicQvxJfbYCqb7dPu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Dec 2005 15:17:52 -0800, Greg KH <greg@kroah.com> wrote:

> On Wed, Dec 14, 2005 at 11:40:16PM -0800, Andrew Morton wrote:
> >   Probably-unfixed bugs from -mm1 and -mm2 include:
> >=20
> >   - "J.A. Magallon" <jamagallon@able.es>: usb_set_configuration() oops.
>=20
> Now fixed in my tree.
>=20

What did Andrew's phrase exactly mean ?
- Still unfixed in -mm3, or
- Unfixed 'till mm2, but fixed in mm3, but not picked by you

I suppose the second, because the fix is present in -mm3.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_Ci9t3qeicQvxJfbYCqb7dPu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDo1icRlIHNEGnKMMRArZkAJ9FINO3Y3pD0ggM0AJU1qgaPuU7zwCfYX8C
d3lLCw6FOMVMpTWiKF95mjw=
=sF0C
-----END PGP SIGNATURE-----

--Sig_Ci9t3qeicQvxJfbYCqb7dPu--
