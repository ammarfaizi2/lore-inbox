Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTENPJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTENPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:09:51 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:6930 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262444AbTENPJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:09:47 -0400
Date: Wed, 14 May 2003 11:22:32 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hdb: dma_timer_expiry: dma status == 0x64 [2.5.69]
Message-ID: <20030514152232.GA1079@babylon.d2dc.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0305132143570.19932@dns.toxicfilms.tv> <20030514134704.GA1062@babylon.d2dc.net> <Pine.LNX.4.51.0305141611130.22227@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0305141611130.22227@dns.toxicfilms.tv>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2003 at 04:13:15PM +0200, Maciej Soltysiak wrote:
> > I'm seeing it too, only with recent kernels.
> Exactly like me.
> Someone suggested Bartlomiej Zolnierkiewicz's patch.
> Try this on for size. I haven't tested it yet, but please give it a shot.

It seems to be in -mm4 and -mm5 as well, and after rebooting to -mm5
=66rom -mm3 I have not seen it, however the box has only been up 2 hours,
so we will know for sure when it happens again, or in a few days?

Thanks.
>=20
> Regards,
> Maciej

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

}>No.  I just point out to troublemakers that I have an English degree,
}>which means that I am allowed to make changes to the English language.
}>(What _else_ could it possibly be for?)
}Wow; in that case, my physics degree is *WAY* more useful than I
}had thought.
This just proves how useless a computer science degree is:  there is hardly
any useful science involved at all.  I want my computer black magic degree!
	-- Victoria Swann, Jonathan Dursi, and D. Joseph Creighton on ASR

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wl84RFMAi+ZaeAERAq7oAKD4PCGOWhoeYx6sJqTEEOJ7qNu2QgCdFOYj
dVGOnUWAK73gX/u3xbCV2Hc=
=LUi1
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
