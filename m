Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267724AbTAHFAC>; Wed, 8 Jan 2003 00:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267734AbTAHFAC>; Wed, 8 Jan 2003 00:00:02 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:1248
	"EHLO localhost") by vger.kernel.org with ESMTP id <S267724AbTAHFAC>;
	Wed, 8 Jan 2003 00:00:02 -0500
Date: Tue, 7 Jan 2003 21:08:10 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: FYI: issue resolved in -dj
Message-Id: <20030107210810.7bb5d8b2.joshk@ludicrus.ath.cx>
X-Mailer: Sylpheed version 0.8.8claws65 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.ay5WCkH)MH4yfV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ay5WCkH)MH4yfV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

just fyi (orig by me):

> 1. [linux-dj] (i think?) after pulling linux-dj i noticed that the
> references to 'font.h' in drivers/video/console were broken. They were
> like#include "font.h" - I have fixed this to refer to the right font.h
> (#include <linux/font.h>)...

Fixed! :D
http://linux-dj.bkbits.net:8080/linux-2.5/cset@1.859?nav=index.html|ChangeSet@-1d

Regards
Josh

--
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest.	


--=.ay5WCkH)MH4yfV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+G7I86TRUxq22Mx4RAgd+AKC93UEjBXiXdejkw7QpoQN+/baCtwCfQfhe
49MlcI37CnpHvw2KPmGmL2I=
=GQcW
-----END PGP SIGNATURE-----

--=.ay5WCkH)MH4yfV--
