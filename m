Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTKZLDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTKZLDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:03:06 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:1250 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S264153AbTKZLDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:03:02 -0500
Date: Wed, 26 Nov 2003 13:02:50 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: s0be <s0be@drunkencodepoets.servebeer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] trivial change in kernel/sched.c in 2.6.0-test9+
Message-ID: <20031126110250.GB27967@actcom.co.il>
References: <20031126002713.1f8707f8.paterley@mail.drunkencodepoets.com> <20031126055556.GC3734@actcom.co.il> <20031126010701.25600adb.s0be@mail.drunkencodepoets.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20031126010701.25600adb.s0be@mail.drunkencodepoets.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2003 at 01:07:01AM -0500, s0be wrote:

> If you can suggest a way to test this, I will test it on my system=20
> tomorrow.

Just off the top of my head, you could try something like a kernel
compilation with and without it. I doubt you'll see any improvement,
though.. there are very few places in the kernel where such
micro-optimizations are worth it, IMVHO.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xIhaKRs727/VN8sRAtmSAJ0aEcQOR0eS0T0iSggCWxMyle6sJgCdG3aH
0da+DqwgOg15sRZRI4+YnmU=
=mePG
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
