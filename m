Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVB1OtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVB1OtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVB1Oqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:46:45 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:46246 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261612AbVB1OpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:45:20 -0500
Date: Mon, 28 Feb 2005 15:45:06 +0100
From: martin f krafft <madduck@madduck.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050228144506.GA11125@piper.madduck.net>
Mail-Followup-To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Pavel Machek <pavel@suse.cz>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net> <200502281533.01621.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <200502281533.01621.rjw@sisk.pl>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.10-9-amd64-k8 x86_64
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Rafael J. Wysocki <rjw@sisk.pl> [2005.02.28.1533 +0100]:
> Could you, please, verify that you don't need to load any modules
> from initrd for your swap partition to work?  It won't work if you do.

this makes perfect sense to me when you talk about resuming. does it
also apply to suspending?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"i never travel without my diary. one should always have something
 sensational to read on the train."
                                                        -- oscar wilde

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCIy5yIgvIgzMMSnURAjDjAKCk0xaW6w0kleWiphmaq05RhbMtJgCfeRZr
0ZIbuV3DS4qt3Fx5CaO1J2E=
=bEuP
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
