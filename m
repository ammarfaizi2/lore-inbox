Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWCWPFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWCWPFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCWPFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:05:43 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:59113 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1751232AbWCWPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:05:43 -0500
Date: Thu, 23 Mar 2006 16:04:24 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: APIC error and APIC in general
Message-ID: <20060323150424.GA2001@lapse.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060323145507.7B4E080ADBD@bell.madduck.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20060323145507.7B4E080ADBD@bell.madduck.net>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.15-1-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Mar 23 15:54:20 cirrus kernel: APIC error on CPU0: 00(40)

I've been getting error like this various times now. The web says
it's usually a hardware problem, defective motherboard, or the like.
The general solution is to append 'noapic' at boot. Sure, this
works, but...

What are the benefits of APIC anyway, and what will I lose if
I disable it?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"reife des mannes, das ist es,
 den ernst wiedergefunden zu haben, den
 man hatte als kind beim spiel."
                                                -- friedrich nietzsche

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEIrj4IgvIgzMMSnURAsNxAJ4+3VFD6gFdUzT+B+gFJmrcGRBtRwCeK70s
xGbLAHUpsf00c6zFRQJYRIs=
=QuI3
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
