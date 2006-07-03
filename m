Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWGCNcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWGCNcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWGCNcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:32:11 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:7894 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751159AbWGCNcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:32:10 -0400
Subject: Re: sound connector detection
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net,
       linux-input <linux-input@atrey.karlin.mff.cuni.cz>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Liam Girdwood <liam.girdwood@wolfsonmicro.com>
In-Reply-To: <200607022248.36459.dtor@insightbb.com>
References: <1151671786.13412.6.camel@localhost>
	 <200607011609.59426.dtor@insightbb.com>
	 <1151832510.5536.32.camel@localhost.localdomain>
	 <200607022248.36459.dtor@insightbb.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eIHtIe5jSEY7FC/Qm2bv"
Date: Mon, 03 Jul 2006 15:31:41 +0200
Message-Id: <1151933502.20701.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eIHtIe5jSEY7FC/Qm2bv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-07-02 at 22:48 -0400, Dmitry Torokhov wrote:

> Maybe we should start looking into connector or a pure netlink
> implementation.

Might not be a bad idea. Then again, the whole alsa API could work over
netlink ;)

johannes

--=-eIHtIe5jSEY7FC/Qm2bv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKkcO6Vg1VMiehFYAQI/HQ//flN1TNnPF2+gzjYTCPKvyp7tENth5sQB
tX/0PtisK7saMisS2mdGh6tUJnjSPqY1pOo4rjMaNcEfynsh3OWh5oRSP6F6eVle
Yde5dTqlH+KBiQqFZCKAC/mQKIbakkws+ewlQaIpMZ85defTLd6GSfRUsf/ILpso
8SFYplOEXG1T8TtU3wcGbH16dkclttsaUpQ5Tv6zu9jhvciaUHvtonb9fq41bgZ6
a0529FAKwk1gQc3w4BJFjGIXAvQjFZoqSGHTXXG18Jrd9ClxxK8iFtxAZ09wza7t
cerWylefcYF16TRKxRVmshbyBbParz+E4mNg7yE7uCPqMWOPoNflETXZu75PwqRX
oZ84H2k0B2EaIGPASoGE+ZYcT/ljMLv1emq1X5smcM6T1bUDglZvSQiWmpQ+HSKv
QxehcMmzTdlZwT8MGzYowTZlaR/p4XeZu5vRtNT44WOI89DTBXCOP7+W02ytmgBE
rzAz5xfJs50wC6wanHTCHNw19cjL3ysIctraAfU51avoZxt5KLRq9vP8lJPHJ7nx
HXHuOrfFfxpeE0tLIeO4U8dDmsBdU0/32xDFZzXJLQxjIWK/R4VACRqiwRMYeFFY
aL/DF8jKlqqM/TTmCQgutfec2BgUs6pmxSvCA5OxlZiH3E8YU2xwC2i8fflreMH6
iUw4fyLiCcM=
=yCmr
-----END PGP SIGNATURE-----

--=-eIHtIe5jSEY7FC/Qm2bv--

