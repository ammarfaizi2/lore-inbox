Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268502AbTANB4R>; Mon, 13 Jan 2003 20:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268503AbTANB4Q>; Mon, 13 Jan 2003 20:56:16 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:7904
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S268502AbTANB4O>; Mon, 13 Jan 2003 20:56:14 -0500
Date: Mon, 13 Jan 2003 18:01:47 -0800
To: Rodrigo Martins Vieira Fonseca <rodrigof@2xr.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.57
Message-ID: <20030114020147.GA4729@kanoe.ludicrus.net>
References: <1042508693.737.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1042508693.737.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Download module-init-tools here:
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

RPMs are also available, but they're for MDK cooker right now and they=20
might not quite fit into the RH structure. Make sure if you compile from=20
source that the prefix is the same as the location of the current=20
modutils (that you will overwrite.)

Hope this helps,
Josh

On Mon, Jan 13, 2003 at 11:52:57PM -0200, Rodrigo Martins Vieira Fonseca wr=
ote:
> I compile the 2.5.57 and have that menssage QM_MODULE : function not
> implemented , and can load any modules, how i fix that, or what i need
> to do? Now i, use redhat 8.0
> Thanks=20
> --=20
> Rodrigo Martins Vieira Fonseca <rodrigof@2xr.com.br>
> 2xr
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+I2+L6TRUxq22Mx4RAuIIAJsEmjB1/3sTeNhq3tgJzqk6BJM8fQCfSiuR
OICHzKwqJ6yRNUfWD2xz1oE=
=ULui
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
