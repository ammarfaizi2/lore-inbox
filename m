Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTDVWro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTDVWrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:47:43 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:37905 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S263890AbTDVWrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:47:41 -0400
Date: Tue, 22 Apr 2003 15:59:43 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: =?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: PATCH: some additional unusual_devs-entries for usb-storage-driver, kernel 2.5.68
Message-ID: <20030422155943.A32297@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	=?iso-8859-1?Q?Hanno_B=F6ck?= <hanno@gmx.de>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	Linux-usb-users@lists.sourceforge.net
References: <20030421214805.7de5e4f3.hanno@gmx.de> <20030422213247.GA5076@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030422213247.GA5076@kroah.com>; from greg@kroah.com on Tue, Apr 22, 2003 at 02:32:47PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2003 at 02:32:47PM -0700, Greg KH wrote:
> Ok, in talking with the usb-storage author, I'll be accepting all
> unushal_devs.h patches now, as long as they contain the following:
> 	- a comment above the entry with a email address of someone who
> 	  has this device that this entry fixes the driver for them.
> 	  This is to allow us to possibly remove entries at a later time
> 	  if the core changes, and get a verification that it's ok to do
> 	  so.
> 	- a copy of the /proc/bus/usb/devices device entry with the
> 	  device plugged in and the driver loaded (this should not be in
> 	  the patch, but in the body of the email.)
> 	 =20
> So, if there are any outstanding drivers/usb/storage/unusual_devs.h
> entries that people have floating around, sent them on!

I want to take a moment publically to thank Greg for doing this, which
allows me to focus my energies on other parts of the driver.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

You suck Stef.
					-- Greg=20
User Friendly, 11/29/97

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+pcleIjReC7bSPZARAj+FAKDBuzvXjzR5rgxCUWvl3RWhmXYunwCgsyVR
tDIZL+MJWWETujXJ79YurS4=
=/iy/
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
