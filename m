Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULXPct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULXPct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 10:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbULXPct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 10:32:49 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:3993 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261157AbULXPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 10:32:47 -0500
From: tabris <tabris@tabris.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel BUG at fs/inode.c:1116 with 2.6.10-rc{2-mm4,3-mm1}[repost]
Date: Fri, 24 Dec 2004 10:31:53 -0500
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412231923.14444.tabris@tabris.net> <20041224000938.22b9f909.akpm@osdl.org>
In-Reply-To: <20041224000938.22b9f909.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1526087.iuZgLB6umB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412241032.02190.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1526087.iuZgLB6umB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 December 2004 3:09 am, Andrew Morton wrote:
> tabris <tabris@tabris.net> wrote:
> > 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple BUG
> > reports) and one from 2.6.10-rc3-mm1, plus dmesg from
> > 2.6.10-rc3-mm1.
>
> Are you using quotas?
	Yes, I am using quotas.
>
> What filesystem types are in use?
	I'm using reiserFS and XFS mostly, with one ext2 partition (/boot,=20
mounted -o sync)

=2D-=20
"The Street finds its own uses for technology."
=2D- William Gibson

--nextPart1526087.iuZgLB6umB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBzDZygbFCivvqDfQRAgD/AKCY5iaJMe6nDsSnxL6+ZHzrigCVlwCaAo1S
F11FQE5yFua4fIzNv3UItY0=
=NJYs
-----END PGP SIGNATURE-----

--nextPart1526087.iuZgLB6umB--
