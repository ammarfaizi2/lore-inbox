Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSIDWAN>; Wed, 4 Sep 2002 18:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSIDWAM>; Wed, 4 Sep 2002 18:00:12 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:48654 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315458AbSIDWAK>; Wed, 4 Sep 2002 18:00:10 -0400
Date: Wed, 4 Sep 2002 15:04:42 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020904150442.N13478@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <UTC200208312329.g7VNTwF11470.aeb@smtp.cwi.nl> <20020904214402.GA8368@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020904214402.GA8368@kroah.com>; from greg@kroah.com on Wed, Sep 04, 2002 at 02:44:02PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd like to hold off a few more days while I try to find out what the
'secret sauce' that the other OSes use for a device like this.

Oh, and I don't think the INQUIRY changes co-mingled in with the other
stuff is really any good.

Matt

On Wed, Sep 04, 2002 at 02:44:02PM -0700, Greg KH wrote:
> On Sun, Sep 01, 2002 at 01:29:58AM +0200, Andries.Brouwer@cwi.nl wrote:
> >=20
> > Without the patch the kernel crashes, or insmod usb-storage hangs.
> > With the patch the CF part of the device works perfectly.
>=20
> Matt, is it ok with you for me to add this patch to the tree?
>=20
> thanks,
>=20
> greg k-h

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

YOU SEE!!?? It's like being born with only one nipple!
					-- Erwin
User Friendly, 10/19/1998

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9doN6IjReC7bSPZARAgc3AJ0QnlKmhIgzYkylEDPh5Go9t2FQJwCeO0q2
eHp9jIP4fJas27cC863lBYI=
=8rWx
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
