Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTICIW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTICIWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:22:25 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:41710 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S261670AbTICIWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:22:23 -0400
Date: Wed, 3 Sep 2003 10:22:11 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903082211.GA2342@deimos.one.pl>
References: <bj447c$el6$1@news.cistron.nl> <20030903074902.GA1786@deimos.one.pl> <1062576819.5058.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1062576819.5058.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:deimos@jid.deimos.one.pl ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.22-rc2-ac3, up 38 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 03, 2003 at 10:13:39AM +0200, Arjan van de Ven wrote:
> > It's standard APIC bug that no one care!

> if you enable APIC (and not ACPI) then you start using a different BIOS
> table for IRQ routing. Several BIOSes have bugs in this table since it's
> not a table that is generally used by Windows on UP boxes. Saying that
> it's the kernel's fault is rather unfair; most (if not all) distros for
> example ship with APIC disabled for this reason.

Maby you have right...

> It's nice if it works for you but there's quite a few boxes out there that
> just can't work.... Don't configure it if you have such a box.

Do not be anger Arjan, but it[1] works from time to time, so it is permanen=
tly
kernel/APIC bug.

Take care.

[1] - via-rhine (eth routing).

--=20
# Damian *dEiMoS* Ko=B3kowski # http://deimos.one.pl/ #

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/VaSzxX49KsOnsvwRApj1AJ4/EIBVOsvMN/++LEzdh4LKBidxWgCeJZ4j
1fOIn3ZlErey34TajV773vY=
=Cb6/
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
