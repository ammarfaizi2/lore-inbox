Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271372AbTG2JxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTG2JxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:53:07 -0400
Received: from pong.to.com ([194.221.251.36]:6150 "EHLO pong.to.com")
	by vger.kernel.org with ESMTP id S271372AbTG2Jv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:51:56 -0400
Subject: Re: via-rhine broken in 2.4.22-pre8 and 2.6.0-pre1&2
From: Stefan Voelkel <Stefan.Voelkel@millenux.com>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F2515A2.8040008@kmlinux.fjfi.cvut.cz>
References: <3F2515A2.8040008@kmlinux.fjfi.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OJn24l6uXvRo8ZPMZViu"
Organization: Millenux GmbH
Message-Id: <1059472268.1086.24.camel@lt-sv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 11:51:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OJn24l6uXvRo8ZPMZViu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

> 2.4.21 still works fine.

I do have watchdog complaints (no resets) with 2.4.21 too. I do not have
access to the box atm, but I suspect NFS since I did experience I/O
errors on copying large files (there was a discussion on lkml about NFS
problems, but I have not followed it)

regards
	Stefan

--=-OJn24l6uXvRo8ZPMZViu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/JkOMtWF28C4HGsQRAlqsAKCfb2RAKF6xxCB82awJuC/j2FLuqgCeJr98
pvFwQPOqZYAFNNrWAYoofLY=
=Fq7g
-----END PGP SIGNATURE-----

--=-OJn24l6uXvRo8ZPMZViu--

