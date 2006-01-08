Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWAHWeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWAHWeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWAHWeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:34:25 -0500
Received: from nsm.pl ([62.111.143.37]:788 "EHLO nsm.pl") by vger.kernel.org
	with ESMTP id S1161151AbWAHWeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:34:24 -0500
Date: Sun, 8 Jan 2006 23:34:11 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs mount time
Message-ID: <20060108223411.GC5586@irc.pl>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601082320520.2801@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2006 at 11:24:02PM +0100, Jan Engelhardt wrote:
> Hi,
>=20
>=20
> brought to attentino on an irc channel, reiser seems to have the largest=
=20
> mount times for big partitions. I see this behavior on at least two=20
> machines (160G, 250G) and one specially-crafted virtual machine
> (a 1.9TB disk / 1.9TB partition - took somewhere over 120 seconds).

  My 177 GiB partition on SATA disc takes about 10 seconds to mount. It
is 1/3 of Linux boot time :(

--=20
Tomasz Torcz                                                       72->|   =
80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   =
80->|


--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDwZNjThhlKowQALQRAgZVAJ95GdkM7hPYTjQyck5Rys0I9uoWrgCgwNDX
G5ucgPeppeoFMvBgiOFh+68=
=HqaM
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
