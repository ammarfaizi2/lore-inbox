Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTE3IIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTE3IIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:08:35 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:52718 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263380AbTE3IId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:08:33 -0400
Subject: Re: Undo aic7xxx changes
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de, willy@w.ods.org,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030530100900.768ceeef.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	 <20030524111608.GA4599@alpha.home.local>
	 <20030525125811.68430bda.skraw@ithnet.com>
	 <200305251447.34027.m.c.p@wolk-project.de>
	 <20030526170058.105f0b9f.skraw@ithnet.com>
	 <20030526164404.GA11381@alpha.home.local>
	 <20030530100900.768ceeef.skraw@ithnet.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zaldLFmvQTpz1j8hwrct"
Organization: Red Hat, Inc.
Message-Id: <1054282892.4897.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (1.3.3-2) (Preview Release)
Date: 30 May 2003 10:21:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zaldLFmvQTpz1j8hwrct
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> My personal opinion is a known-to-be-broken 2.4.21 should not be released=
, as a
> lot of people only try/use the releases and therefore an immediately rele=
ased
> 2.4.22-pre1 with justins driver will not be a good solution.

I think you missed the point entirely before. 2.4.21 CANNOT cause
regressions most of all. At this point there is no way to know if the
thing that fixes your machine breaks on 100s others that DO work
correctly in 2.4.20. Even if it would fix 100s and break 1 it's still
not acceptable for stable kernel releases.


--=-zaldLFmvQTpz1j8hwrct
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+1xSMxULwo51rQBIRAgMaAJwJ9UKcA4FbN3/ncEjrgFXvpfb8jgCfQlRR
DWopHjBCwoKOwDev+GKYd7s=
=NyY6
-----END PGP SIGNATURE-----

--=-zaldLFmvQTpz1j8hwrct--
