Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVBFLPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVBFLPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVBFLPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:15:37 -0500
Received: from mout0.freenet.de ([194.97.50.131]:3297 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261179AbVBFLPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:15:20 -0500
Date: Sun, 6 Feb 2005 12:15:16 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: msdos/vfat defaults are annoying
Message-ID: <20050206111516.GS16853@freenet.de>
References: <4205AC37.3030301@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPMp7S/WMqx7uRDV"
Content-Disposition: inline
In-Reply-To: <4205AC37.3030301@comcast.net>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux samba3.private 2.4.27-1-386
X-Uptime: 12:11:27 up 6 days, 19:48,  5 users,  load average: 0.22, 0.28, 0.26
X-Homepage: http://www.debian.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPMp7S/WMqx7uRDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello John,

Am 2005-02-06 00:33:43, schrieb John Richard Moser:

> So I've noticed, again, much annoyed, that if I rely on -t auto,
> horrible horrible things happen.

Maybe you add the file

  __( '/etc/filesystems' )______________________________________________
 /
|       ext3
|       ext2
|       minix
|       vfat
|       msdos
|       iso9660
|       hfsplus
|       hfs
| nodev	proc
 \______________________________________________________________________

and if you use 'mount -t auto ...' it
will try the filesystems in this order.

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--cPMp7S/WMqx7uRDV
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCBfxEC0FPBMSS+BIRAnOcAJ46W9jWAR5Oq5n8Zm1vDqYWsHsGHgCghDFk
HQR0hNTdd905R4MoaU5vhx4=
=jx1o
-----END PGP SIGNATURE-----

--cPMp7S/WMqx7uRDV--
