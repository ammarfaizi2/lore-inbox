Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVCGPIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVCGPIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVCGPIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:08:52 -0500
Received: from mout2.freenet.de ([194.97.50.155]:26069 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S261337AbVCGPIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:08:49 -0500
Date: Mon, 7 Mar 2005 16:08:46 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: diff command line?
Message-ID: <20050307150846.GD8513@freenet.de>
References: <200503051048.00682.gene.heskett@verizon.net> <20050305161822.H3282@flint.arm.linux.org.uk> <20050307105153.GL26452@freenet.de> <tnxpsybczmp.fsf@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <tnxpsybczmp.fsf@arm.com>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux michelle1.private 2.4.27-1-386
X-Uptime: 16:06:31 up 19 days,  6:14,  6 users,  load average: 0.37, 0.47, 0.53
X-Homepage-1: http://www.debian.tamay-dogan.homelinux.net/
X-Homepage-2: http://michelle.konzack.home.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2005-03-07 14:13:50, schrieb Catalin Marinas:

> Two ways:

not realy good...  :-)


> or
>     $ diff -Nurp src.orig/linux src/linux | filterdiff --strip=3D1

Perfectly... This is what I was searching for...

Because I have original source "src.orig" on one HDD
and my working directory "src" on another.

Now all is working like expected.

> Catalin

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCLG5+C0FPBMSS+BIRAskWAJ97UWbCakQkekBK+QKhtfXGUqKwZwCfec1g
G+H/WBGbmOLiWbql+Laxgq0=
=t1XP
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
