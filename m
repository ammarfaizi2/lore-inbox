Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUJYI3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUJYI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUJYI1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:27:00 -0400
Received: from arnold.london.ongenie.net ([193.113.160.40]:5001 "EHLO
	mail.o2.co.uk") by vger.kernel.org with ESMTP id S261410AbUJYIZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:25:32 -0400
Date: Mon, 25 Oct 2004 10:25:20 +0200
From: matthias brill <matthias.brill@akamail.com>
To: Andrew McGuinness <andrew@arobeia.co.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: atiixp problem with asus L4000R
Message-ID: <20041025082520.GA26561@akamail.com>
Reply-To: matthias.brill@akamail.com
References: <20040821134346.GA7415@akamail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20040821134346.GA7415@akamail.com>
X-Conspiracy: there is no conspiracy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hei andrew,

On Sun, Oct 24, 2004 at 10:34:35AM +0000, Andrew McGuinness wrote:
> Did anyone have any suggestions?  I have the same problem with a Acer=20
> TM2201LC
>
> I have:
> 0000:00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150=20
> AC'97 Audio Controller (rev 01)
> 	Subsystem: Acer Incorporated [ALI]: Unknown device 0065
> 	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 17
> 	Memory at e8004400 (32-bit, non-prefetchable)

takashi didn't reply, but 2.6.9-rc4 did the trick for my IXP150 without
any further problems.  good work for me!

thanks, thias

--=20
Matthias Brill <matthias.brill@akamail.com>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfLhw15PQg+xdZ4cRAuShAJ9fisvq3QZzCpB9dM02+D3L8O5vIwCgj/Vn
TFnPxu7iyh1Ijh5vVHdD2M4=
=bl94
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
