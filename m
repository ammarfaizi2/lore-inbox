Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWBNG5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWBNG5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNG5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:57:10 -0500
Received: from mail.gmx.net ([213.165.64.21]:44007 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030501AbWBNG5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:57:07 -0500
X-Authenticated: #5082238
Date: Tue, 14 Feb 2006 07:57:18 +0100
From: Carsten Otto <c-otto@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
Message-ID: <20060214065718.GA14555@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, penberg@cs.Helsinki.FI,
	linux-kernel@vger.kernel.org, ak@suse.de
References: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI> <20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de> <20060213200429.0521880d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20060213200429.0521880d.akpm@osdl.org>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2006 at 08:04:29PM -0800, Andrew Morton wrote:
> Is that new behaviour?

Yes.

> If so, which was the most recent kernel which
> worked OK?

2.6.15.1 (but without this patch and therefore without sound from the
emu10k1).

> What sort of video card are you using?

Geforce 4 4600 (AGP, NVIDIA). Driver: 8178

Thanks,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8X9OjUF4jpCSQBQRAmqtAJ97nh1CfLG77k+rAlwKyUXbdKKhJQCfRfLL
PEMKE4GQYcod5CZqtereoqE=
=pK+X
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
