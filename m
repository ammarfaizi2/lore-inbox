Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265858AbTF3Tdx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbTF3Tdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 15:33:53 -0400
Received: from debian4.unizh.ch ([130.60.73.144]:16789 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265858AbTF3Tdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 15:33:51 -0400
Date: Mon, 30 Jun 2003 21:48:07 +0200
From: martin f krafft <madduck@madduck.net>
To: Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030630194807.GD25566@piper.madduck.net>
References: <20030630171033.GA27703@diamond.madduck.net> <20030630180002.GA25461@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20030630180002.GA25461@kroah.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.20-grsec+freeswan+preempt-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Greg KH <greg@kroah.com> [2003.06.30.2000 +0200]:
> Not really, sorry.  Make usbcore a module and then just reload it will
> work.

okay, that's an idea.

> For USB development?  Ok...please send us the patches that get USB
> support working under UML as others have wanted to do this for quite
> some time :)

excellent. i am a little afraid that my kernel skills are too low
for this. maybe someone in my team will actually get around to do
it, because UML would really help us!

> Oh, what kind of driver are you working on?

DC motor controllers, Servo motor controllers and A/D converters.
galilmc.com is too expensive for my taste. i work on robots...

take care,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid PGP subkeys? use subkeys.pgp.net as keyserver!
=20
"finally, we have a president who knows
 how to run the government like a business.
 presuming the business is pets.com."
                                                       -- gail collins

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AJP3IgvIgzMMSnURAvHSAJ0ap2bQOy26ARcenwDLi8SAnTpUKQCgt9Wg
o+0XIySWtbrO5bfL4UuJlYE=
=a1yR
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
