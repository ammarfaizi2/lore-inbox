Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFNRh1>; Thu, 14 Jun 2001 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbRFNRhV>; Thu, 14 Jun 2001 13:37:21 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:18189 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S263414AbRFNRhK>; Thu, 14 Jun 2001 13:37:10 -0400
Date: Thu, 14 Jun 2001 19:35:01 +0200
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP spin-locks
Message-ID: <20010614193501.F23383@garloff.etpnet.phys.tue.nl>
In-Reply-To: <Pine.LNX.3.95.1010614132506.10137B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010614132506.10137B-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jun 14, 2001 at 01:26:05PM -0400
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2001 at 01:26:05PM -0400, Richard B. Johnson wrote:
> Question 2: What is the purpose of the code sequence, "repz nop"=20

Puts iP4 into low power mode.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KPXExmLh6hyYd04RArNiAKCs2Dwb52ZBDS/GyJULSIuJrkMYdQCdEypT
dUkJqh0cZVz0HZA+30Rzf4k=
=cJDs
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--

