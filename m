Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRIAXaX>; Sat, 1 Sep 2001 19:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271487AbRIAXaF>; Sat, 1 Sep 2001 19:30:05 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:42252
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S271486AbRIAX3p>; Sat, 1 Sep 2001 19:29:45 -0400
Date: Sat, 1 Sep 2001 16:29:54 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB trouble w/ 2.4.8-ac12
Message-ID: <20010901162954.B2828@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Adam Schrotenboer <ajschrotenboer@lycosmail.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3B916760.1000104@lycosmail.com> <20010901162130.C26407@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010901162130.C26407@kroah.com>; from greg@kroah.com on Sat, Sep 01, 2001 at 04:21:30PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Freecom dongle is well supported for Tape drives (the OnStream USB-30,
in particular), but I haven't gotten it working for other devices yet.

I'm just short on time to work on this.... so if someone is offering to
help, that would be a good thing.

Matt

On Sat, Sep 01, 2001 at 04:21:30PM -0700, Greg KH wrote:
> On Sat, Sep 01, 2001 at 06:55:28PM -0400, Adam Schrotenboer wrote:
> > Using 2.4.8-ac12, USB modules, and a Philips CDRW400.
> >=20
> > I was able to get it to see the CDRW drive once(and that took a minute=
=20
> > or three), but mostly it only sees the Freecom USB-IDE bridge.
> >=20
> > How do I get the usb code to probe the ATAPI bridge for the devices=20
> > behind it??
>=20
> You might try asking on the linux-usb-devel mailing list.  I don't know
> how well the Freecom bridge device is currently supported in Linux.
>=20
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A:  The most ironic oxymoron wins ...
DP: "Microsoft Works"
A:  Uh, okay, you win.
					-- A.J. & Dust Puppy
User Friendly, 1/18/1998

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7kW9yz64nssGU+ykRAhLkAKCHrpx8w/0FOLGnuokSFQnxbsoGDwCgp5l0
VnYFlTL2vx0X9x+3A22wc7A=
=Mv2X
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
