Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTBQMEf>; Mon, 17 Feb 2003 07:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTBQMEf>; Mon, 17 Feb 2003 07:04:35 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10511 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267030AbTBQMEd>;
	Mon, 17 Feb 2003 07:04:33 -0500
Date: Mon, 17 Feb 2003 13:14:31 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: axp-kernel-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030217121431.GR351@lug-owl.de>
Mail-Followup-To: Oliver Pitzeier <o.pitzeier@uptime.at>,
	axp-kernel-list@redhat.com, linux-kernel@vger.kernel.org
References: <001501c2d677$4d5ce0e0$020b10ac@pitzeier.priv.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Content-Disposition: inline
In-Reply-To: <001501c2d677$4d5ce0e0$020b10ac@pitzeier.priv.at>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-17 12:25:35 +0100, Oliver Pitzeier <o.pitzeier@uptime.at>
wrote in message <001501c2d677$4d5ce0e0$020b10ac@pitzeier.priv.at>:
> Leslie Donaldson wrote:
> >    Got the new kernel here are my results.
>=20
> I also downloaded 2.5.61 today. I wasn't able the last 2 days. :-(

I'm running 2.5.60bk3 for nearly three days now.
> >    -) Sound opl3sa2 no compile. Entered patch today

The pnp stuff... This bites PCs, too.

> >    -) make modules_install still has
> >       depmod: Unhandled relocation of type 10 for .text
>=20
> There were also some problems with make modules_install for me!

Worked out of the box for me.

> > well there you go. For clarification until I get a clean install I'm=20
> > not going to try and boot this thing. (I like my raid working.)
>=20
> I'll let it run now... Let's see. If the machine crashes I don't mind too=
 much.
> It's just an old Compaq AS1000 5/333 only used by me as Alpha-teststation=
 and
> some kind of "fileserver".

AXPpci33, I'd probably also switch on my Miata and my Avanti.

> If it works well now and hopefully without crashing, I believe 2.6 will a=
lso
> work fine... :-)

Sometimes, running Linux on !=3D i386 is a bit problematic, typically
because core interfaces or basic functionalities where touched with
arch-specific code only written for i386... But I continue to run my
hardware zoo, asking for the missing bits:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UNInHb1edYOZ4bsRAmO+AJ98NjHg+/jMZYzH0YpNCqekYc0hswCdFtO+
Fwd+E/FRL4Z0iwWfkeX38vY=
=QqQH
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
