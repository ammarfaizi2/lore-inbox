Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUKDPQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUKDPQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUKDPQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:16:00 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:23460 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262256AbUKDPPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:15:42 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
Date: Thu, 4 Nov 2004 16:14:46 +0100
User-Agent: KMail/1.7.1
Cc: Roland Kaeser <roli8200@yahoo.de>, LKML <linux-kernel@vger.kernel.org>
References: <20041104094130.15928.qmail@web26103.mail.ukl.yahoo.com>
In-Reply-To: <20041104094130.15928.qmail@web26103.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2318629.PtsUeb18tE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411041614.57091.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2318629.PtsUeb18tE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 10:41, Roland Kaeser wrote:
> Hello
>
> Here comes the Test report for the UML SKAS and User run Tests
>
> If I run the UML Kernel without the HOSTS SKAS Patch, it works normally, =
no
> hd shutdown!
>
> If i run the UML Kernel with the HOSTS SKAS Patch but as "normal" user, it
> works also normally, without any harddisk shutdown!

> It seems more and more to be a kind of bug in the UML Patch which allows
> the uml kernel to call kernel functions on the host kernel.

Also, there is a host kernel bug which causes the host to crash. Maybe (it =
is=20
just a random try, actually, but there should not be a lot of bugs in 2.6=20
kernels), you could try this: would you please read this thread and tell if=
=20
you can reproduce the described panic and if it is anyhow similar to the=20
other one.

http://groups.google.com/groups?hl=3Den&lr=3D&threadm=3D2WG11-2iJ-1%40gated=
=2Dat.bofh.it&prev=3D/groups%3Fnum%3D25%26hl%3Den%26lr%3D%26group%3Dlinux.k=
ernel%26start%3D50

> Roland


=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart2318629.PtsUeb18tE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBikdxqH9OHC+5NscRAhIIAJ9nne1PgaYgeuKV088B/fwYq7JGNwCfcTmh
fkhF5HnJ0wtmNK8yxOuMShM=
=tgYz
-----END PGP SIGNATURE-----

--nextPart2318629.PtsUeb18tE--

