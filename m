Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbTG3LUc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTG3LUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:20:32 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:7040 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S270218AbTG3LUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:20:19 -0400
Date: Wed, 30 Jul 2003 19:20:14 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Voluspa <lista1@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030730112014.GA994@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20030730123122.3970c7bf.lista1@telia.com> <200307302051.33503.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <200307302051.33503.kernel@kolivas.org>
X-Operating-System: Linux 2.6.0-test2-mm1-kj1+O11.1int
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[~] $ uname -a
Linux amaryllis 2.6.0-test2-mm1-kj1+O11.1int #1 Wed Jul 30 18:57:37 SGT
2003 i686 GNU/Linux

Applied mm1, kj1 (kernel-janitor), and your O11.1int patch.

when X is niced with -10, there are a 1-2 sec pause whenever I switched
=66rom X to console.

when X is niced with 0, there are no skips, no pause, no whatsoever.
even when I maximise aterm, there are no interruptions on my xmms when
i hide, and unhide aterm. nothing unusual when i compile kernels.=20

this is perhaps the best patch i ever applied from you.

Cheers,
Eugene

<quote sender=3D"Con Kolivas">
> On Wed, 30 Jul 2003 20:31, Voluspa wrote:
> > On 2003-07-30 8:41:46 Felipe Alfaro Solana wrote:
> > > Wops! Wait a minute! O11.1 is great, but I've had a few XMMS skips
> > > that I didn't have with O10. They're really difficult to reproduce,
> >
> > Can't reproduce your skips here with my light environment and O11.1 (on
> > a PII 400, 128 meg mem, no desktop, Enlightenment as wm). Even as I
> > write this my machine is under the most extreme load that I have -
> > natural, not artificial:
>=20
> Good test. Thanks.
>=20
> > As to difference between O10 and O11.1 in feel... No comment. I'm too
> > old to catch such small variations.
>=20
> That's good, most of the difference was supposed to be in extremely unusu=
al=20
> circumstances. Felipe's issue is something I was concerned might happen (=
not=20
> specifically an audio issue per se but audio is a sensitive way to pick i=
t=20
> up) which is why all testing is important.
>=20
> Con
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/J6nucyGjihSg3eURAmx4AKCeXcsAtExyAAnQteZuWmOWaucYHgCginUA
909fhjfnmrJfkzG2TCxyfwY=
=RfWu
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
