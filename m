Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUI1QKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUI1QKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUI1QKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:10:20 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:8083 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S267957AbUI1QKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:10:08 -0400
Date: Tue, 28 Sep 2004 18:09:44 +0200
From: Martin Waitz <tali@admingilde.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
Message-ID: <20040928160944.GK4172@admingilde.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Nico Schottelius <nico-kernel@schottelius.org>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost> <1096306153.1729.2.camel@localhost.localdomain> <415954AD.7010905@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <415954AD.7010905@grupopie.com>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Tue, Sep 28, 2004 at 01:10:21PM +0100, Paulo Marques wrote:
> Of course your way is more robust to future 'netif_carrier_ok' changes=20
> and the compiler should optimize it way anyway since it is an inline=20
> function, so I actually prefer the !! version :)

But perhaps those future changes would be interesting for userspace,
too?

--=20
Martin Waitz

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWYzHj/Eaxd/oD7IRAuwUAJ4m00GGSwpzKcICE/c+vsgZqJJGDACfQOlm
xXMkPdP94+hFUrXy3CqRe+k=
=W7Ao
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
