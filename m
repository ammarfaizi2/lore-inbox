Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277141AbRJDFmt>; Thu, 4 Oct 2001 01:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277092AbRJDFm3>; Thu, 4 Oct 2001 01:42:29 -0400
Received: from ip-60-251-043.cyberec.com ([202.60.251.43]:12550 "HELO
	ip-60-251-043.cyberec.com") by vger.kernel.org with SMTP
	id <S276973AbRJDFm0>; Thu, 4 Oct 2001 01:42:26 -0400
Date: Thu, 4 Oct 2001 13:42:46 +0800
From: Andrew Ip <aip@cwlinux.com>
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
Message-ID: <20011004134246.A31806@mail.cwlinux.com>
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>; from sebastien.cabaniols@laposte.net on Wed, Oct 03, 2001 at 02:00:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For those who are interested on trying out journalling filesystem.  I have
made a kernel rpm which supports XFS, JFS, Ext3 and ReiserFS.  You can get =
it
at ftp://ftp.cwlinux.com/pub/downloads/journaling_fs/kernel.  Comments are
welcome.

-Andrew

On Wed, Oct 03, 2001 at 02:00:35PM +0200, sebastien.cabaniols wrote:
> Hello lkml,
>=20
> With the availability of XFS,JFS,ext3 and ReiserFS I am a=20
> little
> lost and I don't know which one I should use for entreprise=20
> class
> servers.
>=20
> In terms of intergration into the kernel, functionnalities,=20
> stability
> and performance which one is the best for entreprise class=20
> servers
>=20
> I guess the begining of the answer is: it depends... on what=20
> you are doing
>=20
> So, what do you think if
>=20
> I want a database server
> or
> a supercomputer (HPC use)
> or
> a Linux KDE/GNOME desktop
>=20
> Thanks for your help, links and experience.
>=20
>=20
> Sebastien CABANIOLS
>=20
>=20
>=20
> "Ce message vous est envoy=E9 par laposte.net - web : www.laposte.net/  m=
initel : 3615 LAPOSTENET (0,84 F TTC la minute)/ t=E9l=E9phone : 08 92 68 1=
3 50 (2,21 F TTC la minute)"
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Andrew Ip
Email:  aip@cwlinux.com
Tel:    (852) 2542 2046
Fax:    (852) 2542 2046
Mobile: (852) 9201 9866

Cwlinux Limited
18B Tower 1 Tern Centre,
237 Queen's Road Central,
Hong Kong.


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7u/bW40rmvSAeXjERAoqgAKC9Jqkp863R/Iiz0UVMbidDX5rn0wCeP0CH
xNHX6JOP6KX2mlN+FqbeQ4A=
=aGsZ
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
