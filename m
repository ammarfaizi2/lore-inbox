Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbQLWEzY>; Fri, 22 Dec 2000 23:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLWEzN>; Fri, 22 Dec 2000 23:55:13 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:41488 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129534AbQLWEzB>; Fri, 22 Dec 2000 23:55:01 -0500
Date: Sat, 23 Dec 2000 05:22:32 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: The NSA's Security-Enhanced Linux (fwd)
Message-ID: <20001223052232.N17117@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A439833.C64D493A@storm.ca> <E149X6e-000525-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E149X6e-000525-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 06:39:49PM +0000
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 22, 2000 at 06:39:49PM +0000, Alan Cox wrote:
> > These folks are good at what they do and the code is GPL.
> > It is worth starting to consider whether this code, or code
> > from one of the other security-enhancement projects, should
> > be included in the standard kernel for 2.6 or 3.0.
>=20
> I think this is a good point. Its actually a nice testimonial for free=20
> software that its finally got the NSA contributing code in a way that eve=
ryone
> benefits from and which may help cut down computer crime beyond governmen=
t.
> (and which of course actually is part of the NSA's real job)

I wonder how their approach compares to the RSBAC stuff, though.
The RSBAC (by Amon Ott) has all the infrastructure available to have
policy based access control; whenever an access decision has to be
taken, a call via some interface is made to a module, which then
takes the decision ... Just like PAM in userspace.
http://www.rsbac.org/

I think it's a good approach and I think, it has gone much further
than the NSA stuff. I'd prefer to have RSBAC merged in 2.5.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6RCiIxmLh6hyYd04RAoE2AJ0fciGawOFgaCLPi5XtHx0on3Lx7QCfR+X8
Qolbk94MyuKAVMZJY7eLuC0=
=7tPP
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
