Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUAHRhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAHRhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:37:14 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:23217 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265778AbUAHRhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:37:07 -0500
Date: Thu, 8 Jan 2004 18:37:06 +0100
From: Martin F Krafft <krafft@ailab.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
Message-ID: <20040108173706.GA21812@piper.madduck.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20040108151225.GA11740@piper.madduck.net> <Pine.LNX.4.58L.0401081452490.30956@logos.cnet> <Pine.LNX.4.58L.0401081508290.30956@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401081508290.30956@logos.cnet>
Organization: AILab, IFI, University of Zurich
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcelo Tosatti <marcelo.tosatti@cyclades.com> [2004.01.08.1810=
 +0100]:
> More information (/proc/mtrr, /proc/interrupts, dmesg, etc) is helpful.

During the lockup, or in general?

And dmesg... during the lockup is not possible. Do you simply want
the boot sequence?

--=20
Martin F. Krafft                Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: krafft@ailab.ch          University of Zurich
Tel: +41.(0)1.63-54323          Andreasstrasse 15, Office 2.20
http://ailab.ch/people/krafft   CH-8050 Zurich, Switzerland
=20
Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver!
=20
"in just seven days, i can make you a man!"
                                      -- the rocky horror picture show

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//ZVCIgvIgzMMSnURAuH1AJ9w5jar761FI7TLZ25/mGgNxYHe6ACfTeEX
pblg2YP78zW/muJX2kmcHYE=
=5UgC
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
