Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTATNKW>; Mon, 20 Jan 2003 08:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTATNKV>; Mon, 20 Jan 2003 08:10:21 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54022 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S265777AbTATNKV>;
	Mon, 20 Jan 2003 08:10:21 -0500
Date: Mon, 20 Jan 2003 14:19:24 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CD Changer
Message-ID: <20030120131924.GO30184@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <002c01c2c001$f36db9f0$0a01a8c0@aaprilhome> <20030120072329.GI30184@lug-owl.de> <00d201c2c083$5aceb460$0500000b@shiva.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZHzn+A9B7nBTGyj"
Content-Disposition: inline
In-Reply-To: <00d201c2c083$5aceb460$0500000b@shiva.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rZHzn+A9B7nBTGyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-01-20 07:56:31 -0500, Alexandre April <alexandre.april@sympati=
co.ca>
wrote in message <00d201c2c083$5aceb460$0500000b@shiva.com>:
> Does it work for IDE CD changer as well ?

Well, they don't exactly have "LUNs", as this is a SCSI thing. You'd
possibly try the ide-scsi module on it, though. Basically, _all_ CD-ROM
drives are (based on their commands) SCSI devices controlled over an IDE
bus. Maybe ide-scsi works here...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--rZHzn+A9B7nBTGyj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+K/dcHb1edYOZ4bsRApCtAJ9ZtoB6m8fIzKep/Jsa0RhbV6gW8wCfbiGc
Lfc8vns8RttKFtPM8LPp1WQ=
=jvHr
-----END PGP SIGNATURE-----

--rZHzn+A9B7nBTGyj--
