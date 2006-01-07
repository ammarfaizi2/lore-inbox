Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWAGOIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWAGOIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWAGOIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 09:08:25 -0500
Received: from mail.gmx.de ([213.165.64.21]:54183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030451AbWAGOIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 09:08:25 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 15:08:43 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107140843.GA23699@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com> <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20060107115947.GY3389@suse.de>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please, don't drop me from the cc list!!)

On Sa, Jan 07, 2006 at 14:57:55 +0100, Jens Axboe wrote:
>(please, don't drop me from the cc list!!)
>
>it might be using the older sg interface, opening read/write to /dev/sgX
>char devices directly. In which case you can't test it with ide-cd,
>sadly.

You wrote about accessing the drive with SG_IO while using ide-cd. So it
is possible to use scsi commands though using ide-cd? I can't find any
documentation on that, though. Could you point me towards it? I can try
to adapt cdparanoia.

Cheers

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDv8trTWouIrjrWo4RAl62AJ47vMB0PN5sivVxBLheDcl6Y6567gCeJ/lG
zL/hiToofoQrDO7EplAu2iQ=
=seeV
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

