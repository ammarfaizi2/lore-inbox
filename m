Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTB0OyY>; Thu, 27 Feb 2003 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTB0OyY>; Thu, 27 Feb 2003 09:54:24 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:36559 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265197AbTB0OyX>; Thu, 27 Feb 2003 09:54:23 -0500
Date: Thu, 27 Feb 2003 16:55:15 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AD1848 OSS driver build fix for 2.5.63-bk (bug #398)
Message-ID: <20030227145515.GB22891@actcom.co.il>
References: <20030227145318.GA22891@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Dz7ZkHOyZKsJidB"
Content-Disposition: inline
In-Reply-To: <20030227145318.GA22891@actcom.co.il>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9Dz7ZkHOyZKsJidB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2003 at 04:53:18PM +0200, Muli Ben-Yehuda wrote:

> This patch fixes bugzilla bug #289,
> http://bugme.osdl.org/show_bug.cgi?id=3D289, PNP API breakage in the
> ad1848 sound driver.=20

Sorry, got my bugs and patches mixed up. For the record, this patch
fixes bug #398. Tested and works fine.
--=20
Muli Ben-Yehuda
http://www.mulix.org


--9Dz7ZkHOyZKsJidB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+XibTKRs727/VN8sRAhC5AKCH6OAI6PNO/Qh0aeO5UZl+MbFlOACbBgYX
HCwiuoZYiL1bZf0+312Pr7I=
=GZQZ
-----END PGP SIGNATURE-----

--9Dz7ZkHOyZKsJidB--
