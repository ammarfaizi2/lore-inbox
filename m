Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGVLaL>; Mon, 22 Jul 2002 07:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSGVLaL>; Mon, 22 Jul 2002 07:30:11 -0400
Received: from coruscant.franken.de ([193.174.159.226]:1931 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S316757AbSGVLaJ>; Mon, 22 Jul 2002 07:30:09 -0400
Date: Mon, 22 Jul 2002 13:32:32 +0200
From: Harald Welte <laforge@gnumonks.org>
To: David Shirley <dave@cs.curtin.edu.au>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: Kernel Panic 2.4.18 - 2.4.19-rc3 when using iptables
Message-ID: <20020722133232.X28824@sunbeam.de.gnumonks.org>
References: <5.1.1.6.0.20020722121603.01cfbda0@pop.cs.curtin.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p550FBWxZTOpK76U"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <5.1.1.6.0.20020722121603.01cfbda0@pop.cs.curtin.edu.au>; from dave@cs.curtin.edu.au on Mon, Jul 22, 2002 at 12:27:01PM +0800
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p550FBWxZTOpK76U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2002 at 12:27:01PM +0800, David Shirley wrote:
> As you can see i'm using the RPC connection tracking module
> that comes with the patch-o-matic stuff.

have  you actually ever read the help message for the RPC conntrack module?

Author: "Marcelo Barbosa Lima" <marcelo.lima@dcc.unicamp.br>
Status: This works now :-)
Status: Ported to 2.4.0-test9-pre2 by Rusty.  May be broken.
Status: Fixed by Marc for 2.4.0.
Status: Ported to newnat by Harald.  May still be broken.

> About 1-2 minutes after I run this script the box hangs, and prints out
> a bunch of register and stack info which I couldn't be bothered to
> type in :P

This is definitely bitrotten code, so don't be surprised if it breaks.

> Cheers
> Dave

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

--p550FBWxZTOpK76U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9O+1QXaXGVTD0i/8RAjz1AJ9anrANO8ZITcoCojTvqnvl16ZQPQCfZ8tZ
b3RCRo5yB8V6fPL4Ua5XGz0=
=eh4C
-----END PGP SIGNATURE-----

--p550FBWxZTOpK76U--
