Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJGQ1I>; Mon, 7 Oct 2002 12:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJGQ1I>; Mon, 7 Oct 2002 12:27:08 -0400
Received: from [209.184.141.189] ([209.184.141.189]:23007 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S261187AbSJGQ1H>;
	Mon, 7 Oct 2002 12:27:07 -0400
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
From: Austin Gonyou <austin@coremetrics.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021006075829.GB23504@marowsky-bree.de>
References: <41EBA11203419D4CA8EB4C6140D8B4017CD8EE@AVEXCH01.qlogic.org>
	 <1033862965.27451.51.camel@UberGeek.coremetrics.com>
	 <20021006075829.GB23504@marowsky-bree.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dr/uW992LnL2IlAsa7D3"
Organization: Coremetrics, Inc.
Message-Id: <1034008359.9137.9.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 07 Oct 2002 11:32:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dr/uW992LnL2IlAsa7D3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-10-06 at 02:58, Lars Marowsky-Bree wrote:
> On 2002-10-05T19:09:26,
>    Austin Gonyou <austin@coremetrics.com> said:
>=20
> > Is there a way to resolve this, either at the driver level, IMHO the
> > place it *should* happen. At the storage level, the place that it could
> > also happen, or in the Kernel?
>=20
> You can always use md multipathing; an extension to the 2.4 multipathing =
has
> been implemented by Jens Axboe and yours truely and is available at
> http://lars.marowsky-bree.de/dl/md-mp; we'll see how Neil takes it when h=
e
> returns from vacation ;-)
>=20
> We'll also be shipping that patch as part of United Linux.

Is this for 2.4 or 2.5. Just FMI.=20


> IBM also did an extension to the LVM1 code to support multipathing; I don=
't
> have an URL handy right now, but Google will certainly help out.
>=20
> For 2.5, this is still not fully hashed out, but I assume you are running=
 2.4
> on a production system ;-)
>=20
>=20
> Sincerely,
>     Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.

--=-dr/uW992LnL2IlAsa7D3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9obcn94g6ZVmFMoIRAoAdAJ4kaIO0Rh0pWP7azEdwxeMkVXwxRwCfeDnX
cQ9mLYveMv22L8jOsSDxC9k=
=HDEm
-----END PGP SIGNATURE-----

--=-dr/uW992LnL2IlAsa7D3--
