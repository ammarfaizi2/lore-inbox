Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVBGNAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVBGNAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 08:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVBGNAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 08:00:54 -0500
Received: from mout1.freenet.de ([194.97.50.132]:41899 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261415AbVBGNAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 08:00:46 -0500
Date: Mon, 7 Feb 2005 14:00:38 +0100
From: Michelle Konzack <linux4michelle@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to read file in kernel module?
Message-ID: <20050207130038.GL12705@freenet.de>
References: <20050207061718.47940.qmail@web52203.mail.yahoo.com> <1107758316.3886.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline
In-Reply-To: <1107758316.3886.58.camel@laptopd505.fenrus.org>
X-Message-Flag: Improper configuration of Outlook is a breeding ground for viruses. Please take care your Client is configured correctly. Greetings Michelle.
X-Disclaimer-DE: Eine weitere Verwendung oder die Veroeffentlichung dieser Mail oder dieser Mailadresse ist nur mit der Einwilligung des Autors gestattet.
Organisation: Michelle's Selbstgebrautes
X-Operating-System: Linux samba3.private 2.4.27-1-386
X-Uptime: 13:58:52 up 7 days, 21:35,  6 users,  load average: 0.00, 0.13, 0.19
X-Homepage: http://www.debian.tamay-dogan.homelinux.net/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 2005-02-07 07:38:36, schrieb Arjan van de Ven:

> the answer really is that you should not read files from kernel
> modules; /proc or otherwise.

I think, he mean something like

    echo "1" >/proc/sys/net/ipv4/ip_forward

Where you can (de)activate Kernel functions.

Greetings
Michelle

--=20
Linux-User #280138 with the Linux Counter, http://counter.li.org/=20
Michelle Konzack   Apt. 917                  ICQ #328449886
                   50, rue de Soultz         MSM LinuxMichi
0033/3/88452356    67100 Strasbourg/France   IRC #Debian (irc.icq.com)

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.pgp"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCB2Z2C0FPBMSS+BIRAmlrAJoDWhLfL2sFGOomGi38rvGebKfx7ACfYJUn
/EwzddDYycfXBPcScOaURNw=
=T+fG
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
