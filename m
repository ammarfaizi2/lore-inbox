Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSDEAoz>; Thu, 4 Apr 2002 19:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDEAoq>; Thu, 4 Apr 2002 19:44:46 -0500
Received: from apollo.bingo-ev.de ([213.70.214.67]:53913 "EHLO
	apollo.bingo-ev.de") by vger.kernel.org with ESMTP
	id <S293175AbSDEAoi>; Thu, 4 Apr 2002 19:44:38 -0500
Date: Fri, 5 Apr 2002 02:44:19 +0200
From: Piotr Esden-Tempski <pe1724@bingo-ev.de>
To: joeja@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020405004419.GA26692@bingo-ev.de>
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I think that the speed of the kernel boot is not the main speed problem.
You may want to try minit written by Fefe. You can download it and test.
I have not tried it myself but I heave seen Fefe's laptop on 18c3 and it
booted really impresive fast.

cheers Piotr

On Thu, Apr 04, 2002 at 06:54:07PM -0500, joeja@mindspring.com wrote:
> Hello,=20
>     Is there some way of making the linux kernel boot faster? =20
>=20
>     While I know that many people here probably don't reboot there machin=
es often, I live in CA where my electrictiy is still high and see no reason=
 to keep a machine on that is not in use (i.e. while I sleep or am at work)=
. =20
>  =20
>     I tested freebsd on an old P133Mhz/32Meg ram and it booted faster wit=
h the GENERIC kernel than linux did on a AMD 1200Mhz/512Meg ram, which seem=
ed odd.  Linux on that same P133 box also took longer than FreeBSD to boot.=
 =20
>=20
>     If I have a machine that does not change from day to day hardware wis=
e why when I boot the thing do I need to probe the hardware again and again=
 each time?  Would passing more options on the command line help like all t=
he addresses and IRQ's of known hardware?
>     Wouldn't it make sense to store this data on the files system? Certai=
nly if something like grub or lilo can figure out how to access a file on t=
he drive the kernel could check for a 'defaults' file or something to get t=
he default irq's, hardware, interrupts, etc from.  Then the kernel could pr=
obe these first and if the probe fails proble elsewhere for the device.
>=20
>   Or is there another way of speeding up the linux kernel boot process?
>=20
> Joe
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
bChat2: http://bchat2.bingo-ev.de                       ___  ___  ___  _  _
bChat: http://bchat.bingo-ev.de                        | _ || _ || __|| |//
ROCK LINUX: www.rocklinux.org                          ||_|||| ||||   |  /
-Born to run kill -9 win                               |  _|||_||||__ |  \
-"Ignorance is bliss." (Matrix)                        ||\\ |_LINUX__||_|\\
GPG Public Key Block: http://www.esden.net/me/esden-key-2002-01-17.asc

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8rPNj87BFPr6YqXARAuz2AJ9j4mftRRzCfpcTf7ZxF6eaFJDGBACgysLd
Iq4LzHgugZFn4dMZJ9HjBFI=
=QyzF
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
