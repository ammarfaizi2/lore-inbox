Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283508AbRLDVxl>; Tue, 4 Dec 2001 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283534AbRLDVxa>; Tue, 4 Dec 2001 16:53:30 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:28778 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S283532AbRLDVxU>; Tue, 4 Dec 2001 16:53:20 -0500
Date: Tue, 4 Dec 2001 22:53:19 +0100
From: Jan-Hendrik Palic <jan.palic@linux-debian.de>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
Message-ID: <20011204215319.GA8239@billgotchy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain> <E16AX5E-0006pH-00@calista.inka.de> <20011203085258.A4072@billgotchy.de> <3C0C1628.5D73F05A@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <3C0C1628.5D73F05A@zip.com.au>
User-Agent: Mutt/1.3.24i
Internet: http://www.billgotchy.de
gpg-key: http://www.billgotchy.de/bin/m.asc
Fingerprint: D146 9433 E94B DD1E AB41  398B 41C3 45C1 331F FF66
Key-ID: 331FFF66
OS: Linux Debian Unstable
Private-Debian-Site: http://www.linux-debian.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ...=20

On Mon, Dec 03, 2001 at 04:17:44PM -0800, Andrew Morton wrote:
>> The IBook freezed and I reseted it .. but I had to install the whole
>> system .. the yaboot wasn't able to find a kernel on the / Partition.
>> (ext3 too) :)
>An unrecovered ext3 filesystem is probably unrecognisable to
>yaboot.  I'm told that yaboot 1.3.5 and later have changes which
>permit booting from unrecovered ext3 filesystems.

hmmm ok ... thnx ... :)

But the IBook freezed with the 2.4.15-ben0 on haevy harddisk/IO ....=20

what could it be?

	Best regards!

			Jan

>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

--=20
One time, you all will be emulated by linux!

----
Jan- Hendrik Palic
Url:"http://www.billgotchy.de"
E-Mail: "palic@billgotchy.de"

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s: a-- C++ UL++ P+++ L+++ E W++ N+ o+ K- w---=20
O- M- V- PS++ PE Y+ PGP++ t--- 5- X+++ R-- tv- b++ DI-- D+++=20
G+++ e+++ h+ r++ z+=20
------END GEEK CODE BLOCK------

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DUXPQcNFwTMf/2YRAcSdAJ4kELswk0Dz5864eWEI/ipZQD6cQACbBkdx
ROmj16yA9bTBhpPyHZooQHg=
=cPSQ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
