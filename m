Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270971AbTHOVWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTHOVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:22:51 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:52705 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S270971AbTHOVWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:22:48 -0400
Subject: Re: Centrino support
From: Martin List-Petersen <martin@list-petersen.se>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Christian Axelsson <smiler@lanil.mine.nu>, linux-kernel@vger.kernel.org
In-Reply-To: <1060980941.29086.25.camel@serpentine.internal.keyresearch.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
	 <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
	 <3F3D417A.5090404@lanil.mine.nu>
	 <1060980941.29086.25.camel@serpentine.internal.keyresearch.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xTHmq0Ys7mJ4Jgn37AfU"
Message-Id: <1060982549.15347.30.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 23:22:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xTHmq0Ys7mJ4Jgn37AfU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-15 at 22:55, Bryan O'Sullivan wrote:
> On Fri, 2003-08-15 at 13:24, Christian Axelsson wrote:
>=20
> > Got a list of supported good working cards?
>=20
> There's a Dell TrueMobile card that uses the Orinoco chipset.  If you're
> feeling like life is too boring, there are cards based on the newer
> Intersil dual 802.11b/g chipsets available, too, and though I haven't
> checked into the shape of the drivers, I know they're under active
> development.

The Dell TrueMobile 1150 series are Agere/Orinoco/Hermes based (MiniPCI
and PC-Card available). All other Dell TrueMobile cards are Broadcom
based and have no Linux driver support either.

There are also MiniPCI, PC-Card, USB adapters with 802.11a/b/g and Linux
drivers available: http://sf.net/projects/madwifi

These are based on the Ateros chipset, which also is around in some OEM
products.

> > > As far as CPU is concerned, if you're using recent 2.5 or 2.6
> > > kernels, there's Pentium M support in cpufreq.  Jeremy
> > > Fitzhardinge has written a userspace daemon that varies the
> > > Pentium M CPU frequency in response to
> > > load.
> >
> > Can you please point me to this daemon?

http://sf.net/projects/cpufreqd

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
"An idealist is one who, on noticing that a rose smells better than a
cabbage, concludes that it will also make better soup." - H.L. Mencken

--=-xTHmq0Ys7mJ4Jgn37AfU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/PU8UzAGaxP8W1ugRAvKSAKDljWAr7K1H/4/Ac+XjB+ppuU8cBgCePhAe
dkqMKOLR1yZ7MeSv/KyKzeU=
=5yRH
-----END PGP SIGNATURE-----

--=-xTHmq0Ys7mJ4Jgn37AfU--

