Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUHVNSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUHVNSG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUHVNR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:17:29 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:65186 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266877AbUHVNPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:15:33 -0400
Date: Sun, 22 Aug 2004 15:15:00 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: emard@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: complete freeze of 2.6.8.1 with ntp
Message-ID: <20040822131500.GC19768@thundrix.ch>
References: <20040821130423.GA6141@tink>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20040821130423.GA6141@tink>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Sat, Aug 21, 2004 at 03:04:24PM +0200, emard@softhome.net wrote:
> I think (can't check) that machine freezes when the ntp has reached
> status of being ready to change kernel's clock synthesizer,=20

What about ltrace/strace?

> the kernel completely halts. No oops, no blinking leds just
> whole machine stops responding.

Does  magic sysrq  still  work?  I.e. is  the  machine syncing  and/or
rebooting on SysRq?

			    Tonnerre

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBKJxT/4bL7ovhw40RAprDAJ4nIOZcdal7Hd2y53qhzM5lq9mmNgCgs9zF
tEc5FoLexn83AE+WOIrRVtk=
=JzYr
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
