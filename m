Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSEaNJq>; Fri, 31 May 2002 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSEaNJp>; Fri, 31 May 2002 09:09:45 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:65287 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315265AbSEaNJn>;
	Fri, 31 May 2002 09:09:43 -0400
Date: Fri, 31 May 2002 17:14:54 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT fs printk() cleanup
Message-ID: <20020531131454.GC310@pazke.ipt>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020531125045.GA310@pazke.ipt> <Pine.LNX.3.95.1020531085628.185A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2002 at 08:59:08AM -0400, Richard B. Johnson wrote:
>=20
> I think it needs to go only to the console....
>=20
> File-system error...
>    printk(...to the file system)
>       makes a file-system error...
>           <forever>

Do you have /var/log on FAT partition or on the floppy ?
Yes, I know about umsdos, but show me one who *really* use it.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE893dOBm4rlNOo3YgRAhIsAKCNB/lxpwUTOHoDUmy+m04xSYfnsgCfQf4t
PtbNZc8weG0Bj36JirGqeJc=
=u0Cs
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
