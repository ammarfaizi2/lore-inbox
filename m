Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265655AbRFWGfv>; Sat, 23 Jun 2001 02:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbRFWGfl>; Sat, 23 Jun 2001 02:35:41 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:33028 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S265655AbRFWGfa>; Sat, 23 Jun 2001 02:35:30 -0400
Date: Sat, 23 Jun 2001 03:36:30 -0300
From: John R Lenton <john@grulic.org.ar>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ACPI or Advanced power ...
Message-ID: <20010623033630.B830@grulic.org.ar>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Steve Kieu <haiquy@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15DL98-0002zE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <E15DL98-0002zE-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2001 at 08:14:26AM +0100, Alan Cox wrote:
> > I need an advice, my machine is i810 chipset and using
> > ACPI bios, but not sure which one i should use in the
> > kernel config. Now I use APM with kernel kapm-idle .
>=20
> If you have the option - use APM not ACPI. ACPI is larger, and right now
> being experimental code - fairly buggy

I agree ACPI sucks, but I have a SMP box that I need to be able to
powerdown remotely. Is there any reason APM can't do that? I mean, I
understand APM was never meant for SMP, but... ?

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
I must have a prodigious quantity of mind; it takes me as much as a
week sometimes to make it up.
		-- Mark Twain, "The Innocents Abroad"

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7NDjugPqu395ykGsRAl/aAJ9+mQQe7BgY4t6KSfvtlksyMICeJACfYcQB
qUtFSBN2K4O88aJvAWo4diY=
=PI17
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
