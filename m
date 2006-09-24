Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWIXOuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWIXOuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWIXOuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:50:12 -0400
Received: from hs-grafik.net ([80.237.205.72]:64014 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1750984AbWIXOuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:50:10 -0400
From: Alexander Gran <alex@grans.eu>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: usb still sucks battery in -rc7-mm1
Date: Sun, 24 Sep 2006 16:49:59 +0200
User-Agent: KMail/1.9.4
Cc: kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
References: <20060924090858.GA1852@elf.ucw.cz>
In-Reply-To: <20060924090858.GA1852@elf.ucw.cz>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?utf-8?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-=7E=24?=
 =?utf-8?q?ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?utf-8?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1854954.a6A7gc8YxQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609241650.02922@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1854954.a6A7gc8YxQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Perhaps your cpu cannot go into deep c states? At least my IBm T40p has tha=
t=20
problem, when USB is enabled.

regards
Alex

Am Sonntag, 24. September 2006 11:08 schrieb Pavel Machek:
> Hi!
>
> I made some quick experiments, and usb still eats 4W of battery
> power. (With whole machine eating 9W, that's kind of a big deal)...
>
> This particular machine has usb bluetooth, but it can be disabled by
> firmware, and appears unplugged. (I did that). It also has fingerprint
> scanner, that can't be disabled, but that does not have driver (only
> driven by useland, and was unused in this experiment).
>
> Any ideas?
> 								Pavel

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://www.grans.eu/misc/pgpkey.asc | Key-ID: 0x6D7DD291
More info at http://www.grans.eu/Alexander_Gran.html

--nextPart1854954.a6A7gc8YxQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFpsa/aHb+2190pERAhwqAJ0dwGKOvj8Vw2gS/5+ihi6XtsArNgCfXDvs
NMTxSvWD6z4lpoISDyACfwY=
=XFir
-----END PGP SIGNATURE-----

--nextPart1854954.a6A7gc8YxQ--
