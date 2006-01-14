Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWANNdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWANNdg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWANNdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:33:36 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:39903 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S932261AbWANNdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:33:35 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Date: Sat, 14 Jan 2006 14:33:23 +0100
User-Agent: KMail/1.7.2
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
References: <20060113032102.154909000@sorel.sous-sol.org> <200601131946.46782.ioe-lkml@rameria.de> <20060113193936.GN3335@sorel.sous-sol.org>
In-Reply-To: <20060113193936.GN3335@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1958724.GnkhArbXZe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601141433.32682.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1958724.GnkhArbXZe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 January 2006 20:39, Chris Wright wrote:
> * Ingo Oeser (ioe-lkml@rameria.de) wrote:
> > Why not include a shorter version of this nice explanation
> > above the list_for_each_entry() loop?
> >=20
> > Like:
> >=20
> > /* We try to find the min MAC address to use in this bridge id. */
>=20
> Send a patch to Stephen ;-)  I'll leave it as is for -stable, since it's
> not a candidate for janitorial cleanups.

=46ine with me. Your argument is perfectly reasonable for me.


Regards

Ingo Oeser


--nextPart1958724.GnkhArbXZe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyP2sU56oYWuOrkARAqeIAJwP/3vfb/PIO5gw/5DfkisgqadXxgCfWLWJ
L5+3l0cXNYr4iUQWXWPmU4c=
=Zag1
-----END PGP SIGNATURE-----

--nextPart1958724.GnkhArbXZe--
