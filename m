Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751723AbWAKSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbWAKSpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWAKSpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:45:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751723AbWAKSpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:45:17 -0500
Message-ID: <43C5522C.6080306@redhat.com>
Date: Wed, 11 Jan 2006 10:45:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jakub Jelinek <jakub@redhat.com>, "David S. Miller" <davem@davemloft.net>,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
References: <20060111.000020.25886635.davem@davemloft.net> <1136967192.2929.6.camel@laptopd505.fenrus.org> <43C4C37B.9020801@redhat.com> <20060111.004418.92939254.davem@davemloft.net> <20060111094854.GK7768@devserv.devel.redhat.com> <Pine.LNX.4.61.0601111935340.19259@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601111935340.19259@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A42F91143BD91B46E6D0525"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A42F91143BD91B46E6D0525
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Engelhardt wrote:
> And ^?

^ is fine.

And just to be complete: I sent DaveM the correct line for that file in
question, I just C&Ped the wrong line my scripts produced.  The mail
seem not to make it to lkml.  In fact, none of my mail originated from
the gmail account ever made it.  I don't know what filter doesn't like me=
=2E

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig5A42F91143BD91B46E6D0525
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDxVIs2ijCOnn/RHQRAiRxAJ91lJ2c6j5eHKnerYI0H4BQFEKEbgCfbF4n
/bDbZGeF+U98vfK/MhBYI8k=
=8aM+
-----END PGP SIGNATURE-----

--------------enig5A42F91143BD91B46E6D0525--
