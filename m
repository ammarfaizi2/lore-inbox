Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbSKQWml>; Sun, 17 Nov 2002 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSKQWml>; Sun, 17 Nov 2002 17:42:41 -0500
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:48565 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S266991AbSKQWmk>; Sun, 17 Nov 2002 17:42:40 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Sun, 17 Nov 2002 17:49:36 -0500
To: Magnus M?nsson <ganja@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RequestIRQ: Resource in use. 2.4.20-rc2
Message-ID: <20021117224936.GA2753@butterfly.hjsoft.com>
References: <20021117221935.GI4722@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20021117221935.GI4722@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2002 at 11:19:35PM +0100, Magnus M?nsson wrote:
> In kernel 2.4.19 my pcmcia-cards works perfactly but in 2.4.20-rc1 and
> 2.4.20-rc2 I am getting the same error on both my pcmcia cards (one=20
802.11b
> wireless card of model D-Link DWL-650 and one 3com card 10/100Mb of=20
some
> kind).
> pcmcia-cs version 3.2.2-1 is used though I am running debian unstable.

i have the exact same story, but in the 2.5 kernels.  orinoco card and
a 3com card.  neither work with anything later than 2.5.45, so i've
been stuck at that kernel.

what's happened the same from 2.4.20-rc1 -> rc2 and from 2.5.45 ->
2.5.46?

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE92B0ACGPRljI8080RAri0AJ96fm3ZgjVtQJ7kdYSAVd/cd36cTgCfZyJv
lUzqBMIoRbKB09bFRVgAMGI=
=up9w
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
