Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTIYXD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTIYXD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:03:57 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:34063 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261825AbTIYXDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:03:53 -0400
Date: Thu, 25 Sep 2003 16:03:51 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: How do I access ioports from userspace?
Message-ID: <20030925160351.E26493@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'd like to be able to access some ioports to some custom hardware directly
from userspace, without creating a specialized kernel-level driver.  Is
there a way to do that?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

M:  No, Windows doesn't have any nag screens.
C:  Then what are those blue and white screens I get every day?
					-- Mike and Cobb
User Friendly, 1/4/1999

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/c3RXIjReC7bSPZARArTPAKDUl1BzTLAAyB81U8rMoBfBRiRdfACfd4m4
X4/VMALFWEwcCy0OptyprmY=
=zUDd
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
