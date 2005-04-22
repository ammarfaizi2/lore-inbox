Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVDVLTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVDVLTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 07:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVDVLTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 07:19:06 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:31545 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261983AbVDVLTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 07:19:01 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org
Subject: Re: SATA/ATAPI
Date: Fri, 22 Apr 2005 13:18:50 +0200
User-Agent: KMail/1.8
Cc: Wakko Warner <wakko@animx.eu.org>
References: <200504211941.43889.tais.hansen@osd.dk> <20050422111404.GA13381@animx.eu.org>
In-Reply-To: <20050422111404.GA13381@animx.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10836592.uSCAugYlpZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504221318.56652.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10836592.uSCAugYlpZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 22 April 2005 13:14, Wakko Warner wrote:
> > One of my linux boxes has a Plextor DVD-RW drive with a SATA interface.
> > The kernel sees this drive (ata3) but apparently doesn't tie it to a sdx
> > device. The box also have a SATA harddisk, which is working just fine.
> > The relevant dmesg output is pasted below.
> I thought all SCSI cdroms were using /dev/scdx or /dev/srx.  Atleast all
> mine are (I use ide-scsi for ide disks)

You thought right. The "/dev/sdx" was just a typo on my side.

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart10836592.uSCAugYlpZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCaN2gLf7B7mQNLngRApoyAJ9MMrzQbgHdf98uVmECFl4cQ/o05wCgqtiX
jPAfvF8ENalyeVe6ueCu9g0=
=5hD5
-----END PGP SIGNATURE-----

--nextPart10836592.uSCAugYlpZ--
