Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbTF3VpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbTF3VpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:45:08 -0400
Received: from mx02.qsc.de ([213.148.130.14]:2455 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S265906AbTF3VpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:45:04 -0400
Date: Tue, 1 Jul 2003 00:03:06 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
Message-ID: <20030630220306.GA17246@gmx.de>
References: <200307010029.19423.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <200307010029.19423.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.73-bk7-O1int i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm running this patch for a couple of hours and it is worse than the
plain 2.5.73-bk7. It doesn't hang exactly (and I didn't listen to any
music, yet) but during normal work (switching x-screens, scrolling in
browser, pressing keys, etc.) the systems hangs non-deterministically
for maybe half a second or so. For example, when I typed this sentence I
noticed that pressing the backspace key didn't trigger anything for a
while and then it continued with the sentence (correctly, tho).
I cannot reproduce it and the machine is doing virtually nothing. Please
tell me if you need more information.

On Tue, Jul 01, 2003 at 12:29:19AM +1000, Con Kolivas wrote:
> Buried deep in another mail thread was the latest implementation of my
> O1int
> patch so I've brought it to the surface to make it clear this one is
> significantly different from past iterations.
>
> Summary:
> Decreases audio skipping with loads.
> Smooths out X performance with load.

--=20
Regards,

Wiktor Wodecki

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ALOa6SNaNRgsl4MRAoPyAKCkwR39wzLrdc8uJ7ZOw0DHaCrpJwCgkutK
LKl+vJVwQC65i+Dm/V6RyNM=
=OrL+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
