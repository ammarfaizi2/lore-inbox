Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTANSOX>; Tue, 14 Jan 2003 13:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTANSOX>; Tue, 14 Jan 2003 13:14:23 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4320
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S264883AbTANSOW>; Tue, 14 Jan 2003 13:14:22 -0500
Date: Tue, 14 Jan 2003 10:22:58 -0800
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: audio resamples itself
Message-ID: <20030114182258.GA16359@kanoe.ludicrus.net>
References: <Pine.LNX.4.51.0301141703080.7796@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0301141703080.7796@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I had a lot of problems with i810_audio, have you tried the ALSA drivers
either as modules for 2.4 or built-in for 2.5? (the module name is intel8x0)
They seem to work great for me.

-Josh

On Tue, Jan 14, 2003 at 05:11:37PM +0100, Maciej Soltysiak wrote:
> Hi,
>=20
> i put my hdd to a different computer, which has:
> 00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2)
> Chipset AC'97 Audio Controller (rev 12)
>=20
> i noticed that when i play music with xmms it has the habit of changing
> the sampling rate to something that sounds like 11k, (sharp aliased sound)
> when eg. i open/close windows, click, etc. I know that i810 can handle
> only 48k, i changed xmms preferences to play at 48k, but it still does it.
>=20
> The previous computer had an sb live and it was fine.
>=20
> Did anybody notice similar behaviour with this driver / chip ?
>=20
> Regards,
> Maciej
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JFWC6TRUxq22Mx4RAn2kAKCWSii6yQAxR+gH+giOob7DJGuJqACgpxWP
v56k6xxWgC8U545s6JWwMZ0=
=madi
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
