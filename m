Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbTF2IAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 04:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265606AbTF2IAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 04:00:33 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:59664 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265605AbTF2IAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 04:00:32 -0400
Date: Sun, 29 Jun 2003 10:14:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030629081447.GC29233@lug-owl.de>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <3EF86019.3090608@pobox.com> <Pine.LNX.4.10.10306281917040.1116-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WJCYmJUqSxpJwZtQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10306281917040.1116-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WJCYmJUqSxpJwZtQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-06-28 19:17:53 -0700, Andre Hedrick <andre@linux-ide.org>
wrote in message <Pine.LNX.4.10.10306281917040.1116-100000@master.linux-ide=
.org>:
>=20
> The best rule is to default it off and let the end user enable regardless.
> Thus the default will NEVER encounter the issues seen now.

While I was the one who initially had the "trouble", I was thankful for
having a "Switch It On by Default" option. I don't exactly know what the
patch did to the IDE subsystem (personally I'm not really into IDE...),
but I'd unhide a problem (either my dumb drive/controller setup or a bug
in Linux' IDE code) and so - one more bug down (at least from my point
of view). That's a good thing, IMHO.

This *is* why I'm using 2.5.x - there's actually a chance to easily find
bugs with everybody's hardware:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--WJCYmJUqSxpJwZtQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/p/3Hb1edYOZ4bsRAmuWAJ9Ne73KBjSNr/tT9G8R9dUWesm5xQCeLe7m
DbjuWFud0zjc1TRTqFxJ4jM=
=iqie
-----END PGP SIGNATURE-----

--WJCYmJUqSxpJwZtQ--
