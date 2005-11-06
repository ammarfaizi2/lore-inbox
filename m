Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVKFGWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVKFGWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 01:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVKFGWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 01:22:46 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:62407 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750916AbVKFGWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 01:22:46 -0500
Message-ID: <436DA120.9040004@t-online.de>
Date: Sun, 06 Nov 2005 07:22:24 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>, 333052@bugs.debian.org
CC: Kay Sievers <kay.sievers@vrfy.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu>
In-Reply-To: <20051105184802.GB25468@ojjektum.uhulinux.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC6388C1C342D217BB25EDFB"
X-ID: Z2zlXiZXgeM3D-yWhBdlWqFSqR4yP6Ew6HRacWpVqNRjhhzGo-Chgy
X-TOI-MSGID: 630d0cd4-8227-4583-8b2b-690222120eb8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC6388C1C342D217BB25EDFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Pozsar Balazs wrote:
> On Sat, Nov 05, 2005 at 06:31:04PM +0100, Kay Sievers wrote:
> 
> 
> With my patch, modprobe waits until the needed modules come out of the 
> "Loading" or "Unloading" state.
> 
> 

For testing I have added it to Debian's
module-init-tools 3.2-pre9. Works for me.


Regards

Harri

--------------enigBC6388C1C342D217BB25EDFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbaEnUTlbRTxpHjcRAjjKAKCS9GuDXdUv0nxfdX5BNS/f9KwERACgkjqj
tPL4IvtkZYumJ6Q1fUkTvhs=
=Wgs6
-----END PGP SIGNATURE-----

--------------enigBC6388C1C342D217BB25EDFB--
