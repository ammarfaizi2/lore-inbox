Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUIVOMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUIVOMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUIVOMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:12:45 -0400
Received: from ns.schottelius.org ([213.146.113.242]:12928 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S265477AbUIVOMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:12:42 -0400
Date: Wed, 22 Sep 2004 16:16:30 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /sys: Network device status: link; Hard disks?
Message-ID: <20040922141630.GE694@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everybody!

Will /sys provide details about link status of network cards
and can I also find out what devices are harddisks?

Like having /sys/block/hda/type, which contains "cd-rom" or
"harddisk" or similar.=20

Or having something like /sys/class/net/eth0/link with 0/1 setting?

I know some or all information can be retrieved somehow differnt
(like using /proc), but shouldn't those be found in /sys?

Just some question on how we can use /sys useful.

Greetings,

Nico

PS: Please CC, I am not subscribed.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQVGJPLOTBMvCUbrlAQJG7Q/+PZ0lcLQxHjmT/HB5wiwL2ulbLLw7lUo6
LTdRFY7OLd7RlB3MTvPNU23rye7fW7v19TUzRzen67Ti3qOrpL4K9fpBxOEsCY3n
Nisnr3qNcVrCaMkvitDHapNicgurRt39JCJ2cKL/oih12n9T3+Ba3Vu9Mo2oxOGw
tfeNfzwptSv4fULX8I3otK0t96wurSX9FolPqucs+jidIzSiUAiJirQnkBro/Gio
jmtpC/uXWDjPYJ4thUEfj4jyGTIfIb9C4DrwgA4ggkF52TZkZo0sSft+RHZ+SCVs
OCuwfUhPmIChNbXcSa6sG2fsDp2+U1GQvifG9AXzbsvWr86d+E0iiMmFrXZ2oMIt
vQhljy8bSYhoPVXA1nr4eZFPsTr1fQ0AGUBBznZ2xTAwPhqLIdIgWKU0nojSQB1G
J9I8cTADOfjig1O4KhXIr1+G2lhplFwozCQTiwqYaP7pLftkWLITDyr90rfI3OtR
UHdPogokpLxwmNBG+zrE0OuKNkWgUoDMK2ej9UZeHgNvycRcIyixecI6mSSfv8Ax
sRBriqq9LYrafdWQABykIwCzffYflQm3E9t3uL8+Gcsp7ELk4d4tzoQFSt92XNgK
Ojz5QRus+SyUDqeNCwI4uhCvbMudGN4JRvzDAjo0gqrmBKgKb3WtDVvxQJFL4Kq9
DLI1GXAY9Rg=
=wk3o
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
