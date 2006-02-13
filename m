Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWBMUQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWBMUQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBMUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:16:33 -0500
Received: from mail.gmx.net ([213.165.64.21]:28122 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964853AbWBMUQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:16:33 -0500
X-Authenticated: #5082238
Date: Mon, 13 Feb 2006 21:16:44 +0100
From: Carsten Otto <c-otto@gmx.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
Message-ID: <20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	linux-kernel@vger.kernel.org, ak@suse.de
References: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 12:16:22PM +0200, Pekka J Enberg wrote:
> Does the following patch fix your problem?

Yes, it does (I moved to 2.6.15.4 in the same step, though).

Unfortunately my PC freezes as soon as I start a 3D game (Enemy
Territory True Combat Elite) when I see the first few 3D ingame frames.
Running glxgears is fine, as is running multiple instances of VLC to
output several audio streams through one device.
Switching off the sound in ET:TCE does not help at all.

Bye,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8OksjUF4jpCSQBQRAs4SAJwJhJspTNDY0o9J8kow/1P9ZdtStACgllue
V6OI+kUm4Q94n2FG55ybwAI=
=Pwcu
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
