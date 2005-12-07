Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbVLGGcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVLGGcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVLGGcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:32:00 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:36524 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932548AbVLGGb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:31:59 -0500
Date: Wed, 7 Dec 2005 12:46:10 +0530
From: Harald Welte <laforge@gnumonks.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Jiri Benc <jbenc@suse.cz>,
       Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051207071610.GC4361@rama.exocore.com>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051205190038.04b7b7c1@griffin.suse.cz> <4394892D.2090100@gentoo.org> <20051205195543.5a2e2a8d@griffin.suse.cz> <4394902C.8060100@pobox.com> <20051205195329.GB19964@redhat.com> <20051206151046.GF4038@rama.exocore.com> <4395E0E3.4040601@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <4395E0E3.4040601@pobox.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2005 at 02:05:07PM -0500, Jeff Garzik wrote:
> Harald Welte wrote:
> >I also think that there is a lack of knowledge on the architecture of
> >802.11 low-level protocols and drivers among many people (including
> >myself) in the network community.  Only this way I can explain why there
> >are always people who claim that the kernel already has a 802.11
> >'stack'.
>=20
> This last sentence, regardless of the source, is simply playing with word=
s.

I don't think that having clear definitions of certain terms is playing
with words.  I don't neccessarily care which words are used, but it's
always useful to have common, well-defined terminology.

I also wouldn't call the TCP code a stack, if it hadn't all the state
engine in it. =20

> We have 802.11 common code in the kernel, that several drivers are
> using. =20

Yes.

> Future drivers should modify that common code to suit their
> needs, rather than dropping it and starting from scratch.

I did not state that it has to be replaced.  I'm much in favour of
gradual changes myself.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlow6XaXGVTD0i/8RAjBDAKCd78Py8EsqyE0Njc7BIL2bOiEHagCfUz6V
IaDv+ovK8LPgWDjc23ysj4g=
=aNsK
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
