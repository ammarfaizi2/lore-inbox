Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWGYTWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWGYTWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWGYTWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:22:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964832AbWGYTWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:22:21 -0400
Message-ID: <44C66FC9.3050402@redhat.com>
Date: Tue, 25 Jul 2006 12:23:53 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: async network I/O, event channels, etc
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2668695AE66A8136A2AC2B2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2668695AE66A8136A2AC2B2F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I was very much surprised by the reactions I got after my OLS talk.
Lots of people declared interest and even agreed with the approach and
asked me to do further ahead with all this.  For those who missed it,
the paper and the slides are available on my home page:

http://people.redhat.com/drepper/


As for the next steps I see a number of possible ways.  The discussions
can be held on the usual mailing lists (i.e., lkml and netdev) but due
to the raw nature of the current proposal I would imagine that would be
mainly perceived as noise.

So the second proposal is the I can create an appropriate mailing list
here.  Alternatively possibly two lists, one for the event channel stuff
and one for the DMA/AIO part since the two parts are very much unrelated.=


I'd appreciate input from those who feel responsible for these lists.  I
don't mind either way.  If there is strong interest right now (let me
know, don't pollute the list) I can create mailing lists now and then if
necessary close them down and redirect traffic to lkml/netdev.

Waiting for input...

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig2668695AE66A8136A2AC2B2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFExm/J2ijCOnn/RHQRAr+0AJ9ATJxV9MkVDBTtB3q8xF98bYxxQACgwr3t
f9YThdt9MvZP5wXijQNOCzo=
=bQRW
-----END PGP SIGNATURE-----

--------------enig2668695AE66A8136A2AC2B2F--
