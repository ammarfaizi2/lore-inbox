Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143409AbREKVqa>; Fri, 11 May 2001 17:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143408AbREKVqV>; Fri, 11 May 2001 17:46:21 -0400
Received: from ndslppp45.ptld.uswest.net ([63.224.227.45]:13131 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S143407AbREKVqF>;
	Fri, 11 May 2001 17:46:05 -0400
Date: Fri, 11 May 2001 14:46:20 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.4ac7 oops, locks in init on boot
Message-ID: <20010511144620.A10308@debian.org>
In-Reply-To: <20010511130202.A8660@debian.org> <E14yJ8M-0001c2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yJ8M-0001c2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 09:03:30PM +0100
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2001 at 09:03:30PM +0100, Alan Cox wrote:
> > I'm considering it, but for AGP weirdness reasons.  Have the USB bugs b=
een
> > worked out?  I am highly dependant on USB.
>=20
> Only one stepping of the AMD chip had the USB funnies. AMD released the i=
nfo
> needed to work around it and its now in the tree.

Ah, thanks Alan.  I may need to consider the AMD boards seriously if I
can't get the Radeon 64 working on the KT7A in the next few weeks.  I'm
hoping -ac7 will fix that.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

<taniwha> Knghtbrd: we should do a quake episode :knee deep in the code":
          you run around shooting at bugs:)
<Knghtbrd> taniwha: I'll pass the idea on to OpenQuartz  ;>


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjr8XawACgkQj/fXo9z52rPXmgCfU2ghgUPM6W/FLfSPuvZoxur3
fyUAn0zvGfPUw0ts89T0b5uN5aZu86Ak
=axFt
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
