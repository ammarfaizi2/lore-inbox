Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbTF3VVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbTF3VVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:21:55 -0400
Received: from debian4.unizh.ch ([130.60.73.144]:47776 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265900AbTF3VVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:21:52 -0400
Date: Mon, 30 Jun 2003 23:36:04 +0200
From: martin f krafft <madduck@madduck.net>
To: Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: restarting a kernel thread
Message-ID: <20030630213604.GA3974@piper.madduck.net>
References: <20030630194807.GD25566@piper.madduck.net> <20030630203941.GA26216@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20030630203941.GA26216@kroah.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.20-grsec+freeswan+preempt-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Greg KH <greg@kroah.com> [2003.06.30.2239 +0200]:
> Any reason for not sticking with userspace programs using libusb/usbfs?
> Much easier to write than kernel drivers, and you get portibility
> across a wider range of OSs

Well, that's a good idea. Problem is that the drivers are actually
written by someone else. I just developing with them, and them
a little on the side.

But I'll pass the word on to the developers. Is this an easy
transition?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid PGP subkeys? use subkeys.pgp.net as keyserver!
=20
"the public is wonderfully tolerant.
 it forgives everything except genius."
                                                        -- oscar wilde

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AK1EIgvIgzMMSnURAmcCAKCIIegOl3GqXYSBKGhpGEgbNMhNpACfSCx/
rty7Tv5OYvfeYgn6rj2VXe8=
=utO8
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
