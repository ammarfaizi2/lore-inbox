Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270498AbTHQTJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270499AbTHQTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:09:06 -0400
Received: from main.gmane.org ([80.91.224.249]:12231 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270498AbTHQTJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:09:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Centrino support
Date: Sat, 16 Aug 2003 12:58:42 -0700
Message-ID: <m2d6f5gyrx.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
 <m2oeyq3bi2.fsf@tnuctip.rychter.com>
 <1060980793.29086.21.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
X-Spammers-Please: blackholeme@rychter.com
Cancel-Lock: sha1:/YMxU5rJ620Qavyofri0/gTAqzE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Bryan" =3D=3D Bryan O'Sullivan <bos@serpentine.com>:
 Bryan> On Fri, 2003-08-15 at 13:35, Jan Rychter wrote:
 >> I keep dreaming about the day when I'll be able to have a modern
 >> laptop with a stable Linux kernel. As for now, it has taken me (on
 >> one of my laptops) about 1.5 years to get to a point where 2.4
 >> works, most of my hardware works, and software suspend (pretty much
 >> a requirement for laptops) works. I'm not about to give that up
 >> easily, so I'm not that eager to jump to 2.5/2.6.

 Bryan> Can't say that's been my experience.  I bought a new Thinkpad
 Bryan> X31 the other day, and it's already running 2.6.0-test3.
 Bryan> Suspend works, all's happy.

Lucky you! That's because almost two years (or so) of heavy work by many
people went into this. Also, you're probably lucky with your Thinkpad.

When I bought this laptop (a Sharp Mebius PC-MT1-H5) back in Sept 2001,
there weren't many machines on the market that had only ACPI (and no
APM). And Linux ACPI wasn't in a very sane state back then, not to
mention swsusp. It took almost two years for the software to mature, and
only recently did I get a stable machine that I can work on for a month
without rebooting (suspending/resuming several times a day).

I've just gotten a Centrino-based Toshiba Dynabook SS S7/290LNKW, and
the story continues -- I've already hit at least two ACPI bugs, while
swsusp problems seem to have been ironed out thanks to hard work by
Nigel Cunningham. And of course, the built-in wireless card does not
work. My guess is another 6 months (if not more) until Linux works on
it.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/PozzLth4/7/QhDoRApuyAJ9mTmIuLVxoJQmL8QTCH2VfyMktegCgjq9i
H1Lty3BVNqJBh460sP8kRfo=
=CQQd
-----END PGP SIGNATURE-----
--=-=-=--

