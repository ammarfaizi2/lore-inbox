Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTICVeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbTICVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:34:24 -0400
Received: from [24.241.190.29] ([24.241.190.29]:17836 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264672AbTICVeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:34:22 -0400
Date: Wed, 3 Sep 2003 17:34:17 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nmi errors?
Message-ID: <20030903213417.GT7353@rdlg.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030903212038.GQ7353@rdlg.net> <Pine.LNX.4.53.0309031724470.362@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309031724470.362@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



We ran "memtest" on the machine over the weekend and it completed 3
times without any problems.  Know a better or different test?


Thus spake Richard B. Johnson (root@chaos.analogic.com):

> On Wed, 3 Sep 2003, Robert L. Harris wrote:
>=20
> >
> >
> > Can anyone tell me what this is?
> >
> > 16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason 31.
> > 16:00:09 mailserver kernel: Dazed and confused, but trying to continue
> > 16:00:09 mailserver kernel: Do you have a strange power saving mode ena=
bled?
> > 16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason 21.
> > 16:00:34 mailserver kernel: Dazed and confused, but trying to continue
> >
> > A coworker put a script on a server which loads up quite afew arrays
> > with pre-set values and then compares the values against arrays.  As so=
on as he
> > kicked off the script I got alot of these in my log files.  Not much lo=
nger and the
> > machine crashed hard.
> >
>=20
> Possible bad RAM.
>=20
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
>             Note 96.31% of all statistics are fiction.
>=20

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/Vl5Z8+1vMONE2jsRApYSAJ4rTwGPtxzKnmy/T9JIlDp2UL62lACgqywK
qrVe+BFanSjCJroV7VOdAzU=
=s8C+
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
