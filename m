Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272702AbTG1HpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272709AbTG1HpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:45:05 -0400
Received: from mx02.qsc.de ([213.148.130.14]:8401 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S272702AbTG1HpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:45:01 -0400
Date: Mon, 28 Jul 2003 10:00:07 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030728080007.GB660@gmx.de>
References: <200307280112.16043.kernel@kolivas.org> <20030728075106.GA660@gmx.de> <20030728005543.0dca9531.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20030728005543.0dca9531.akpm@osdl.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test2-O10 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Jul 28, 2003 at 12:55:43AM -0700, Andrew Morton wrote:
> Wiktor Wodecki <wodecki@gmx.de> wrote:
> >
> > The same problem I wrote you
> >  yesterday about O9, when starting OpenOffice and bzip2'ing in the
> >  background OO becomes nearly unusable
>=20
> There's a known problem with OpenOffice and its use of sched_yield().=20
> sched_yield() got changed in 2.6 and it makes OO unusable when there is
> other stuff happening.
>=20
> Apparently it has been fixed in recent OpenOffice versions.  If you cannot
> reproduce this problem in any other application I'd be saying it is "not a
> bug".

No, I have tried others. I'll write 'OO-Update' on my ToDo as #434355
then.

--=20
Regards,

Wiktor Wodecki

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JNgH6SNaNRgsl4MRAr3iAJ9M/wxh2Na4Vf1AYjCZEi3ZDKk+SwCcDoG9
jXORK0aGjGEFG1e1wEUBggY=
=dOhw
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
