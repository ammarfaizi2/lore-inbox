Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTAIUVZ>; Thu, 9 Jan 2003 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267768AbTAIUVZ>; Thu, 9 Jan 2003 15:21:25 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4320
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267767AbTAIUVX>; Thu, 9 Jan 2003 15:21:23 -0500
Date: Thu, 9 Jan 2003 12:19:59 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Radeonfb in 2.5.54bk (now 2.5.55)
Message-Id: <20030109121959.605cd0c1.joshk@ludicrus.ath.cx>
In-Reply-To: <Pine.LNX.4.44.0301091816340.5660-100000@phoenix.infradead.org>
References: <20030107154141.259f84c3.joshk@ludicrus.ath.cx>
	<Pine.LNX.4.44.0301091816340.5660-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.8.8claws70 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.ITFKQl30RzIlu4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ITFKQl30RzIlu4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Same problem. 2.5.55bk with pulled fbdev-2.5 and -dj

Regards
Josh

Rabid cheeseburgers forced James Simmons <jsimmons@infradead.org> to
write this on Thu, 9 Jan 2003 18:17:08 +0000 (GMT):	

> 
> > Latest patch? If it's the one you pushed to BK a day or two ago,
> > that is what I used in the compilation of my kernel. Hence it
> > doesn't quite work.
> > 
> > (to be precise, i issued:
> > bk clone http://linux.bkbits.net:8080/linux-2.5
> > bk -r get
> > bk pull http://fbdev.bkbits.net:8080/fbdev-2.5)
> > 
> > Anything wrong there? Do I have to bk -r get again?
> > 
> > Looks like I am subscribing to this list then. Sigh... too many
> > lists to take care of!! :(
> 
> More changes happened. Can you try another pull.
> 
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest. 

--=.ITFKQl30RzIlu4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Hdlx6TRUxq22Mx4RAhHSAKCp5OLVVCM6h73PT4h3pHJFWVYWKACghW8L
H+N6AQJcYXz9J/j7geKxEas=
=I9yJ
-----END PGP SIGNATURE-----

--=.ITFKQl30RzIlu4--
