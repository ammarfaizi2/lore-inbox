Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVCGKwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVCGKwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVCGKwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:52:08 -0500
Received: from mout0.freenet.de ([194.97.50.131]:4064 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261741AbVCGKv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:51:58 -0500
Date: Mon, 7 Mar 2005 11:51:53 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: diff command line?
Message-ID: <20050307105153.GL26452@freenet.de>
References: <200503051048.00682.gene.heskett@verizon.net> <20050305161822.H3282@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <20050305161822.H3282@flint.arm.linux.org.uk>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux michelle1.private 2.4.27-1-386
X-Uptime: 11:47:41 up 19 days,  1:55,  5 users,  load average: 0.01, 0.08, 0.14
X-Homepage-1: http://www.debian.tamay-dogan.homelinux.net/
X-Homepage-2: http://michelle.konzack.home.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Russell,

Am 2005-03-05 16:18:24, schrieb Russell King:
> On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
> > What are the options normally used to generate a diff for public=20
> > consumption on this list? =20
>=20
> diff -urpN orig new

This is what I using curently

diff -Nurp src.orig/linux src/linux >src.diff/linux

Now I have a question: How can one create this Type of patches ?
(Curently I am using scripts to strip "src.orig" and "src")

Index: linux-sd/include/linux/mmc/host.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-sd/include/linux/mmc/host.h	(revision 138)
+++ linux-sd/include/linux/mmc/host.h	(working copy)
@@ -51,6 +51,11 @@
 #define MMC_POWER_OFF		0


I was searching the commandline parameters for it...
(using Debian GNU/Linux)

Thanks
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCLDJJC0FPBMSS+BIRAvfLAJ4sbg9qUtARpiFXWfCMpk4pdtViUACePFVi
eedqJ1WH0RxQeQ/8briRU5w=
=J7J8
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
