Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTBKWwD>; Tue, 11 Feb 2003 17:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbTBKWwD>; Tue, 11 Feb 2003 17:52:03 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:31492 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S266643AbTBKWwB>;
	Tue, 11 Feb 2003 17:52:01 -0500
Date: Tue, 11 Feb 2003 18:01:46 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-eata@i-connect.net
Subject: Re: eata irq abuse (was: Re: Linux 2.5.60)
Message-ID: <20030211230146.GA1291@babylon.d2dc.net>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-eata@i-connect.net
References: <3E4936BF.3050809@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <3E4936BF.3050809@colorfullife.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2003 at 06:45:35PM +0100, Manfred Spraul wrote:
> >[<c0291df2>] port_detect+0x3c2/0xe50
>=20
> Do you have an eata scsi controller?

Yes I do, does exactly what I need most of the time.

The problem goes away if I compile SCSI as modules, however it happens
when I try to load the modules, so..

Anything I can do to help?

Zephaniah E. Hull.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"This system operates under martial law. The constitution is suspended. You
 have no rights except as declared by the area commander. Violators will be
  shot. Repeat violators will be repeatedly shot...."       -from "A_W_O_L"

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+SYDaRFMAi+ZaeAERArN7AJ9rZOIotKPpmjso3cFHeekd9XF8yQCdFpyY
nCcZ9ojw/h45uJ3s5B7zP38=
=0sbL
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
