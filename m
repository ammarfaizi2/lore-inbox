Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVBGMyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVBGMyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVBGMyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:54:04 -0500
Received: from mout1.freenet.de ([194.97.50.132]:50116 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261414AbVBGMxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:53:55 -0500
Date: Mon, 7 Feb 2005 13:53:53 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207125353.GK12705@freenet.de>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <20050207004218.GA12541@ojjektum.uhulinux.hu> <20050207024800.GA18010@hobbes.itsari.int> <20050207084709.GA30680@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <20050207084709.GA30680@ojjektum.uhulinux.hu>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux samba3.private 2.4.27-1-386
X-Uptime: 13:51:25 up 7 days, 21:28,  6 users,  load average: 0.35, 0.30, 0.24
X-Homepage: http://www.debian.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2005-02-07 09:47:09, schrieb Pozs=E1r Bal=E1zs:

> See? I _have_ that patch applied, that's why it tried vfat and not msdos=
=20
> first.

With this, you will nerver mount a Filesystem "msdos".

Because "vfat" IS "msdos" + "lfn".

You can attach to ALL "msdos" media "lfn" and you will have "vfat".

> Granted, I could override the default order by using a /etc/filesystems=
=20
> file. But the kernel should have a much more sane default on its own,=20
> namely "try vfat before msdos".

This will give many errors here at work...

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCB2ThC0FPBMSS+BIRAuagAJ4yHlJAN2KvRkEZATV1jU0UcvbnFQCgqGJ0
nUm0pBsPbBAPkHSRLdI+i6A=
=ITh6
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
