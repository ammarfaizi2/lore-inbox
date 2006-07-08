Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWGHLUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWGHLUS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWGHLUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:20:18 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:59607 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964783AbWGHLUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:20:16 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sat, 8 Jul 2006 21:20:08 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>,
       Arjan van de Ven <arjan@infradead.org>, Jan Rychter <jan@rychter.com>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <1152357077.2088.4.camel@beast.rexursive.com> <20060708111359.GJ1700@elf.ucw.cz>
In-Reply-To: <20060708111359.GJ1700@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2810568.xApizbCcyX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607082120.13145.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2810568.xApizbCcyX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 08 July 2006 21:13, Pavel Machek wrote:
> > AFAIK, none of the solutions have GUI inside the kernel.
>
> Then you need to read suspend2 patch again.

No. You do. The kernel code sends netlink messages to a userspace app. It=20
doesn't know or care whether or how that app displays the messages. All it=
=20
does is send the status, or if there's no userui, do some printks.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2810568.xApizbCcyX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEr5TtN0y+n1M3mo0RAucWAKDBbuHiwTaD7Le2DgN+bkfbJGb7qQCgx7Fh
KdpXixYRfQSZ1k5daRS5OUk=
=VeGI
-----END PGP SIGNATURE-----

--nextPart2810568.xApizbCcyX--
