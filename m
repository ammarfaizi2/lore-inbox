Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269119AbRHBUF3>; Thu, 2 Aug 2001 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269112AbRHBUFT>; Thu, 2 Aug 2001 16:05:19 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:39783 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269111AbRHBUFD>; Thu, 2 Aug 2001 16:05:03 -0400
Date: Thu, 2 Aug 2001 22:05:11 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent device numbers
Message-ID: <20010802220511.B5269@nbkurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru> <E15SJbh-0000iJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <E15SJbh-0000iJ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-early i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2001 at 03:37:49PM +0100, Alan Cox wrote:
> You are mostly talking about a user space problem in reality. Things like
> scsiinfo for example build a directory of scsi path based names to the
> disks, and the mount code supports mounting by volume label.

scsidev.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7abJ2xmLh6hyYd04RAhbBAJ0efQ2VBT2xycU88ppE7BupnvVlWwCfYbXy
5kV3e5GooH39u395qQVrF8U=
=p2/4
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
