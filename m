Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSLHRX7>; Sun, 8 Dec 2002 12:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSLHRX7>; Sun, 8 Dec 2002 12:23:59 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:53010 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S261376AbSLHRX5>;
	Sun, 8 Dec 2002 12:23:57 -0500
Date: Sun, 8 Dec 2002 12:31:34 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.50-ac1
Message-ID: <20021208173134.GA27423@babylon.d2dc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
References: <200212081549.gB8Fnx527793@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <200212081549.gB8Fnx527793@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2002 at 10:49:59AM -0500, Alan Cox wrote:
> *** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
>=20
> This starts to clear the decks of pending 2.5.5x patches. It took a lot
> of effort to get anything worth running out of 2.5.50 hence they delay.
> A measurable chunk of these build fixes are already in (or came from)
> Linus BK tree so .51 ought to be a lot better.

Unless I somehow have a bad tree (which I will verify in a moment), this
does not seem to compile at all.

make[2]: *** No rule to make target `kernel/configs.c', needed by
`kernel/configs.o'.  Stop.
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.50-ac1'

The .config used is attached.

Zephaniah E. Hull.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Why blow away at a partition when you can chip away at it?  I now
present a script I just wrote that writes random bits of, well random
bits, into random places in your favorite partition or file.  For best
(meaning most spectacular) results, use while the database or
filesystem is in active use.

Disclaimer:  This code is untested, and it may or may not trash your
filesystem and/or database.  While at least a half-assed effort has
been made to ensure that it works as designed, there is no guarantee
that its use will result in a loss of important data.  I am not liable
for the lack of either direct or incidental damages.
  -- Logan Shaw on ASR.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE984H2RFMAi+ZaeAERAqXzAJ46eieEDc3y09B/WwGZgIUPHmDgwwCeJSWq
6hv6fWPhV48r02wnG0y7168=
=jbn0
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
