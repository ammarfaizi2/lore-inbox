Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313160AbSDSXt1>; Fri, 19 Apr 2002 19:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSDSXt0>; Fri, 19 Apr 2002 19:49:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15369 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S313160AbSDSXtY>;
	Fri, 19 Apr 2002 19:49:24 -0400
Date: Sat, 20 Apr 2002 01:49:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Trouble rebooting Tyan Thunder K7 (S2462UNG)
Message-ID: <20020419234921.GK17295@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWUeX0Da3WGxUUMKAAAAQAAAAb2jlXi9TM0a+IKeYbO47lAEAAAAA@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-04-19 23:15:23 -0000, Jordan Breeding <jordan.breeding@attbi.c=
om>
wrote in message <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWU=
eX0Da3WGxUUMKAAAAQAAAAb2jlXi9TM0a+IKeYbO47lAEAAAAA@attbi.com>:
>   I am having trouble getting a brand new Tyan Thunder K7 S2462UNG (the
> one with onboard SCSI) to reboot successfully using Linux.  This board

> FreeBSD do with this board, instead the text stays there for at least
> 15-20 seconds (maybe longer) then when it finally blanks the video and
> the monitor light begins to flash it goes straight into the Adaptec
> SCSISelect scan (I can tell because my HD light comes on and the CDROMs

What is so uncommon? The board does use ECC RAM, so maybe the board's
BIOS / firmware needs this time to blank and check all the RAM. Maybe
othe OSes don't initiate a full "cold boot" but something that doesn't
make the board to re-initialize all the RAM...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzArQEACgkQHb1edYOZ4buCLACfTBJva9HiHT7shMuZcO2zU86M
LGMAnA258R+E5BAM7UQ19C8enF+YL1/v
=jLrS
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
