Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVJaLIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVJaLIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJaLIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:08:22 -0500
Received: from wg.technophil.ch ([213.189.149.230]:40593 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751051AbVJaLIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:08:21 -0500
Date: Mon, 31 Oct 2005 12:08:16 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Rescan SCSI Bus without /proc/scsi?
Message-ID: <20051031110816.GB16691@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20051031110344.GA16691@schottelius.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20051031110344.GA16691@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Googling better before makes sense:

On
http://bash.cyberciti.biz/diskadmin/rescan-scsi-bus.sh.html
is a script using /sys. Though it does not work on linux-2.6.13 here,
I'll search what's broken.

Nico

Nico Schottelius [Mon, Oct 31, 2005 at 12:03:44PM +0100]:
> Hello!
>=20
> As noticed in 2.6 kernels, on should not use /proc/scsi anymore.
>=20
> This breaks the popular rescan-scsi-bus.sh from Kurt Garloff.
> Is there a possibility to do that through /sys somehow or do I have
> to reanable /proc/scsi?
>=20
> Greetings,
>=20
> Nico
>=20
> --=20
> Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
> Open Source nutures open minds and free, creative developers.



--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ2X7H7OTBMvCUbrlAQIVpg//X0Gx3/eO5m4wS5ogVy22y8i3rwKZqBQD
ESsuyJ2lwh6caYcsqnOo5YB5svEW/HcFaDxlR+lRnMwMGeYd7C7kHhZ/8XYFMBct
SJGljYEdQtSle98qpMaN+Ldw0Bts5EO4w+rP5jrmsKruXRAcxYmfjAQGwmQ8m00a
VKqGVGihbzgAKF7OByUBWUZD4zquErPe4GXDIfbaPOr3ck0hidsWDEsGdcExbxko
EJ3gdV7QABCar1BMDTXuzyE/y1ycV8nSJJwqTdOP0MQYi3j1vXRIbIO+7+FF+FHH
TkunHSN76uxWRo2cd/jd5KYXn6xQkmf71FcYDVGXi060fl3AWf1GLWjJikHpVyEp
Mkbs21ITBMg9I+aXXtSp9NwpHxY/zviuHH74uab55MmqbFIDQmUfCz9LZg0HKB9B
WBVm4BIuFcf+otytGDMmVXbhFuF7wUCMH3pEs9rh/BjqHkLJjcgc5Wr2YN81clgJ
BuGBeEqfyPy7n0M54jIF1J4cqgrKqIOcxz93w7G1ggk930dpa/jZjFnrZGOw2CPY
PU0xAHXXTHkZ91JLfxygk9hnpKPYMRtznPlTYpEXuZKn+5ZI3tIIQbMhqcoWdB1Y
xe+0YUtSccTs5uyrLpzTnHXxMW2d6MDcQEa5UEax9IChSUxZDIqjHdH/e8S0CAtN
0bN7QwR59Ls=
=urXG
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
