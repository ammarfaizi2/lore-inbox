Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTFUVfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTFUVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 17:35:48 -0400
Received: from main.gmane.org ([80.91.224.249]:5805 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265373AbTFUVfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 17:35:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [OT] Troll Tech
Date: Sat, 21 Jun 2003 14:49:48 -0700
Message-ID: <m21xxnxfr7.fsf_-_@tnuctip.rychter.com>
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <1056027789.3ef1b48d3ea2e@support.tuxbox.dk>
 <03061908145500.25179@tabby> <20030619141443.GR29247@fs.tum.de>
 <bcsolt$37m$2@news.cistron.nl> <20030619165916.GA14404@work.bitmover.com>
 <20030620001217.G6248@almesberger.net>
 <20030620120910.3f2cb001.skraw@ithnet.com>
 <20030620142436.GB14404@work.bitmover.com>
 <20030620162719.GA4368@hh.idb.hist.no> <bd12o3$5t5$2@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
Cancel-Lock: sha1:Fq+EAwI61JAgtj92qNKnqJw9dQ8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Henning" =3D=3D Henning P Schmiedehausen <hps@intermeta.de> writes:
 Henning> Helge Hafting <helgehaf@aitel.hist.no> writes:
[...]
 >> I don't think open source is so parasitic.  Commercial software have
 >> a head start, open software is still catching up in many fields.

[...]

 Henning> Look how long it took Linux to get a really decent driver for
 Henning> the eepro100 chips, which are commodities parts these
 Henning> days. And only after Intel finally decided that there is no
 Henning> more interesting IP in the docs and released them for free.

 Henning> Check the level of support of _current_ graphics chips in
 Henning> Linux. You get a halfway decent ATI support, "bad, bad, bad
 Henning> closed source" but performance-wise very good nVidia support
 Henning> and Matrox is a bad joke (judging from my experience of trying
 Henning> to get a G550 with DVI running).

That's a problem which is inherent in open-source software, because
manufacturers do not release the specs. But it could be alleviated. I'm
especially surprised that it doesn't change much even though companies
like Intel start to "support" Linux.

Look at Linux on laptops. I've just checked: it took more than a year
and a half for Linux on my laptop to become stable and usable in most
aspects. A year and a half! During this time, I've been going through
endless upgrades of ACPI, kernel (for things like USB, and because ACPI
required it), swsusp and wireless card drivers.

Several days ago I've finally achieved a stable, reasonably-working
solution. Which means that my wireless card doesn't crash too often, the
system is able to suspend and resume and not die in the process, and
thermal management works. I'm very happy now. I'm also very grateful to
all the people who made this possible. But I also know that the cycle
will start all over again very soon -- as soon as I get one of the new
Centrino-based laptops. And I know that I won't be able to use 2.4 much
longer -- very soon support for new hardware will be in 2.5/2.6
only. See cpufreq for an example.

The sad thing is that most distribution vendors care much more about
putting the latest and greatest "graphic environments" than stabilizing
the base system. Not surprising, given that sales of desktop Linux are
driven by press reviews and press concentrates *exclusively* on "it has
the GNOME 2.X and KDE 3.X with a gazillion new colorful animated
click-them thingies".

=2D-J.=20=20
PS: I'm actually quite surprised that swsusp receives so little
attention from the "core" kernel developers. It seems as if nobody uses
laptops? Or do people just reboot so often?

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9NL9Lth4/7/QhDoRAm1tAKDhgbD2kXfuuZe/VntMdiqdL8fugQCcCo7J
40tiQ4/Trt/WDIBG5p9lpQU=
=DloO
-----END PGP SIGNATURE-----
--=-=-=--

