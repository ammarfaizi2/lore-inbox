Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319462AbSIGJvH>; Sat, 7 Sep 2002 05:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319463AbSIGJvH>; Sat, 7 Sep 2002 05:51:07 -0400
Received: from coruscant.franken.de ([193.174.159.226]:33468 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S319462AbSIGJvG>; Sat, 7 Sep 2002 05:51:06 -0400
Date: Sat, 7 Sep 2002 11:51:25 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Lee Van Dyke <VandykeL@masirv.com>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Wanted: netfilter:arptables working example.
Message-ID: <20020907115125.M9675@sunbeam.de.gnumonks.org>
References: <3D78AC8F.8050409@masirv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3D78AC8F.8050409@masirv.com>; from VandykeL@masirv.com on Fri, Sep 06, 2002 at 06:24:31AM -0700
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Pungenday, the 24th day of Bureaucracy in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2002 at 06:24:31AM -0700, Lee Van Dyke wrote:
> Wanted: netfilter arptables working example.
>=20
> I've looked throught the archives and am unable to find any examples.

there is none.  david miller has introduced netfilter hooks to arp and port=
ed
iptables to arp (called arptables).  However, there is no userspace program
for configuration (yet?).

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+=
=20
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9ecwcXaXGVTD0i/8RApS8AKCoqk1JFyPR/g24lvgZOCw+WclA1gCfQYLo
zkcP9ZgbEBk6XYEZtuBlxe8=
=5Wxb
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
