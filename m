Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVB0RyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVB0RyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVB0RxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:53:02 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:5058 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261466AbVB0RnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:43:18 -0500
Date: Sun, 27 Feb 2005 18:43:09 +0100
From: martin f krafft <madduck@madduck.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050227174309.GA27265@piper.madduck.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050226153905.GA8108@localhost.localdomain> <20050227170428.GI1441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20050227170428.GI1441@elf.ucw.cz>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.10-9-amd64-k8 x86_64
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pavel Machek <pavel@suse.cz> [2005.02.27.1804 +0100]:
> Ugh, too late, I already forgot what went wrong for you. Anyway
> try reading Documentation/power/swsusp.txt and/or going to
> 2.6.11-rc4. If that does not help, debug with printk :-).

I already did the first two. I will try 2.6.11-rc4 now.

Please check my first post, if you have the time:

  http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D110789536921510&w=3D2

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"it always takes longer than you expect, even when
 you take into account hofstadter's law."
                                                 -- douglas hofstadter

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCIgatIgvIgzMMSnURAj2/AKDNmzKYbTBScw5thnhrQG3nY2jJlgCg6yhU
ytR07+pJaNLIqX/e3ViYUK4=
=Skp9
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
