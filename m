Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUF2Lu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUF2Lu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUF2LuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:50:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:60346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265722AbUF2LuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:50:24 -0400
Date: Tue, 29 Jun 2004 13:45:23 +0200
From: Kurt Garloff <garloff@suse.de>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: hwscan hangs on USB2 disk - SCSI_IOCTL_SEND_COMMAND
Message-ID: <20040629114523.GY4732@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Bart Hartgers <bart@etpmod.phys.tue.nl>, linux-kernel@vger.kernel.org
References: <20040629093739.40243364C@etpmod.phys.tue.nl> <20040629094557.GR4732@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3a/Z8KDuKqDOIvAo"
Content-Disposition: inline
In-Reply-To: <20040629094557.GR4732@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.5-17-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3a/Z8KDuKqDOIvAo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2004 at 11:45:57AM +0200, Kurt Garloff wrote:
> Does it work if you send the INQUIRY with 36 bytes allocation length?
> scsi_cmd_buf[8 + 4] =3D 0x26;

I mean 0x24 of course ...
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--3a/Z8KDuKqDOIvAo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4VZTxmLh6hyYd04RAo39AKCg4/OjSj3cH9MEfdB+rinTMft45gCgxFqt
xLOoB9kSVdR0USShLtf67DA=
=xpzt
-----END PGP SIGNATURE-----

--3a/Z8KDuKqDOIvAo--
