Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVBASFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVBASFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBASEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:04:15 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:38016 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262094AbVBASDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:03:21 -0500
Date: Tue, 1 Feb 2005 10:03:13 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Stick read-only in 2.6.10
Message-ID: <20050201180313.GA15549@one-eyed-alien.net>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <cto2rs$tuu$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <cto2rs$tuu$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Did you turn on CONFIG_USB_STORAGE_RW_DETECT?

Matt

On Tue, Feb 01, 2005 at 09:28:45AM -0500, Bill Davidsen wrote:
> I upgraded a system from 2.4.19 (or so) to 2.6.10. Using a USB memory=20
> stick reader one, and only one, stick is now read-only.
>  - I can't go back, this was a backup/reinstall upgrade
>  - it doesn't happen on Win98
>  - it doesn't happen on WinXPhome
>  - it doesn't happen on OSX
>  - it doesn't happen in the camera
>  - it doesn't happen with four other sticks bought at the same time
>    and used in the same camera
>=20
> Out of the box FC2 + 2.6.10 built from kernel.org source.
>=20
> Before I start playing with the drivers and all, is there a known oddity=
=20
> in this area which I missed searching?
>=20
> --=20
>    -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
>  last possible moment - but no longer"  -me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB/8RhIjReC7bSPZARAqcWAJ4+6Zlu0TgsbIo9CJXa5bOe+gQJsQCggkiM
wTO/nUKqgxHqEDeDiNRzvYc=
=yVMy
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
