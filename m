Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbQLVBTe>; Thu, 21 Dec 2000 20:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131645AbQLVBTZ>; Thu, 21 Dec 2000 20:19:25 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:21261 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S131630AbQLVBTI>; Thu, 21 Dec 2000 20:19:08 -0500
Date: Fri, 22 Dec 2000 01:42:41 +0100
From: Kurt Garloff <garloff@suse.de>
To: John Covici <covici@ccs.covici.com>
Subject: Re: 2.4.0 kernels and vpn
Message-ID: <20001222014241.I7400@garloff.etpnet.phys.tue.nl>
In-Reply-To: <20001222012105.G7400@garloff.etpnet.phys.tue.nl> <Pine.LNX.4.21.0012211924100.2739-100000@ccs.covici.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012211924100.2739-100000@ccs.covici.com>; from covici@ccs.covici.com on Thu, Dec 21, 2000 at 07:25:18PM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2000 at 07:25:18PM -0500, John Covici wrote:
> Excuse my ignorance, but what is cipe?

CIPE =3D Crypto IP Encapsulation.
See
http://sites.inka.de/~W1011/devel/cipe.html

Some version of cipe is in the kerneli patches:
ftp://ftp.YOURCOUNTRY.kernel.org/pub/linux/kernel/people/astor/

I'd recommend using FreeS/WAN, though as it's a standardized solution,
even offering interoperability with other OSes.

> Also, I received a comment that all I had to do was enable gre
> tunneling, is this correct?

This does not give you the P from VPN.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6QqOBxmLh6hyYd04RAq93AKCjsyliqKUqdmmxkQ0R6BKGa46gkgCgsrhB
xLIHBrv08Vzy64vLs76HFN0=
=ow6/
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
