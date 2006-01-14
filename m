Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWANOgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWANOgs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWANOgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:36:48 -0500
Received: from nsm.pl ([62.111.143.37]:37663 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1751456AbWANOgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:36:47 -0500
Date: Sat, 14 Jan 2006 15:36:42 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: change eth0 to sn0        ?
Message-ID: <20060114143642.GA13111@irc.pl>
Mail-Followup-To: Bernd Eckenfels <be-news06@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <BAY17-F23F48DE88AB5E02BB7AF8A97190@phx.gbl> <E1ExmHK-00087S-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <E1ExmHK-00087S-00@calista.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2006 at 03:21:14PM +0100, Bernd Eckenfels wrote:
> >     $ ifconfig eth0 down
>       # nameif sn0 00:11:2F:38:07:D9

 Better use standard tools:

 ip link set name sn0 dev nf

--=20
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDyQx6ThhlKowQALQRAh56AJ9U/HKmk0NqXfUf21zrbTqH7JdF8ACfUU7a
i7bzudEZ4qBL//SEs6T/TEU=
=8ORZ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
