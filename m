Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbTAIVCu>; Thu, 9 Jan 2003 16:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTAIVCu>; Thu, 9 Jan 2003 16:02:50 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:3808
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267746AbTAIVCr>; Thu, 9 Jan 2003 16:02:47 -0500
Date: Thu, 9 Jan 2003 13:02:04 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-Id: <20030109130204.7f91e6dd.joshk@ludicrus.ath.cx>
In-Reply-To: <20030109200428.GB3345@gagarin>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
	<20030108015107.GA2170@gagarin>
	<20030108095253.B23278@ucw.cz>
	<20030109200428.GB3345@gagarin>
X-Mailer: Sylpheed version 0.8.8claws70 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=..nFiXV,.x/o,Yr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=..nFiXV,.x/o,Yr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Strangely, I only notice this problem when I use GNOME2.
I fired up windowmaker this morning for the first time in a while and
the mouse doesn't skip at all - nothing even in dmesg. Perhaps GNOME is
passing some bunk parameters to xset?

Regards
Josh

Rabid cheeseburgers forced Anders Gustafsson<andersg@0x63.nu> to write
this on Thu, 9 Jan 2003 21:04:29+0100:	

> On Wed, Jan 08, 2003 at 09:52:53AM +0100, Vojtech Pavlik wrote:
> > 
> > That I'd like to know, too. In the worst case, we can make the
> > timeout be half a second, or more - it'd just mean that for a resync
> > you would have to not touch the mouse this long if really a byte is
> > lost.
> 
> Still havn't misbehaved here with the extended timeout. So it seems
> that it really helped.
> 
> -- 
> Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest.

--=..nFiXV,.x/o,Yr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HeNO6TRUxq22Mx4RAkIOAKCZBljmOouaPv6BmaJjjCtKxK3JywCfQMW/
mDNQfM0iMg6YC5TqWQTLpTU=
=sf4i
-----END PGP SIGNATURE-----

--=..nFiXV,.x/o,Yr--
