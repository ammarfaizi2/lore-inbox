Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUJWSti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUJWSti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUJWSti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:49:38 -0400
Received: from ns.schottelius.org ([213.146.113.242]:32900 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261271AbUJWStf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:49:35 -0400
Date: Sat, 23 Oct 2004 20:49:10 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Paulo Marques <pmarques@grupopie.com>,
       Stephen Hemminger <shemminger@osdl.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices
Message-ID: <20041023184910.GD1297@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20041021112750.GN15294@schottelius.org> <Pine.LNX.4.61.0410221744500.15769@jjulnx.backbone.dif.dk> <Pine.LNX.4.61.0410231216110.3151@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost> <1096306153.1729.2.camel@localhost.localdomain> <415954AD.7010905@grupopie.com> <20040928160944.GK4172@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410231216110.3151@dragon.hygekrogen.localhost> <20040928160944.GK4172@admingilde.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9-cLinux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 22 Oct 2004, Jesper Juhl wrote:
> [sysfs kernel patch]
> Good news,=20
> Linus has merged the patch in 2.6.10-rc1 so unless someone finds a flaw=
=20
> with it or otherwise complains about it it should be in 2.6.10 once that=
=20
> is released.

I tested it in 2.6.9 and it works without any problems. I even
included it in an isntallation script and tested pluggin cable
out and in, works like charme.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQXqno7OTBMvCUbrlAQIXXw/+OCyGHQsHpC8UC2jDQ+5DpuSBs+Y2/ltX
MfZWe+q5AYmEqp1Gb/6Sfg6yW18LybzUr6aRWC/AYqaDBO21n9j3REqO73eAGYBG
V/jkkdjWQkGTbZJng1388wyWIYfSlYpwM1fp2IyGVOKo8zNPhcxchHTFS7QTaN9i
RaxrRBMoCTAUtDpqOA+vzcxUSBn+AdHozrALGGRF5ZyNY6AAXknItTU8MozMVcIT
g6OZixWabjYu2OuqqD8luGnR6JyZj3ULaiNenTD5Qe/JhogshxoyOa6DERNqffhX
a16wGTFggwt/r0mkTGX/ppMyN8qjFuu2PM+3VE2WRkjdNwneSz3QLrgPqCetEfBJ
pQSj9wu6GVeleJwPGs4cMpHE3b07aYs/N/Kz3uw4BhRlOV7XNedEX1laAJ3doVoo
kwkkI/W1URjuZlVwLF40oLlK9KFZd07A5hD6T0ujrmxZCPsddQZbiW6oUEyJkY12
R1cOroutbXk1NUqGv1KTfwvQxE8ZIddERrrmH5v32mqVaujit60s1X0Uad64VNwp
Zcf3+pHwPeszBThkk04957GyMEC8Y0/GN6hRutHslyvlnAIFxyGUeAalAz17tbsL
mTxShUQ6SNe4jvjteRi+tVHzoBNXq+xVdPAfpq9EOaA4oduwQgWlW51fKqMCV9EV
IDsnGJqBt0I=
=gwdN
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
