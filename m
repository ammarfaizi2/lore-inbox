Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTKCN1A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKCN1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:27:00 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:9125 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262015AbTKCN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:26:57 -0500
Date: Mon, 3 Nov 2003 14:25:57 +0100
To: Szymon Aceda?ski <accek@poczta.gazeta.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics losing sync
Message-ID: <20031103132557.GD27206@puettmann.net>
References: <N7gI.1K3.9@gated-at.bofh.it> <E1AG4NH-0006xZ-00@baloney.puettmann.net> <200311021048.33698.accek@poczta.gazeta.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <200311021048.33698.accek@poczta.gazeta.pl>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1AGeiT-0000hd-00*C5hYJXISqM.* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2003 at 10:48:33AM +0100, Szymon Aceda?ski wrote:

                hy,
=20
> "Losing too many ticks" exists when I'm running with cpufreq [p4_clockmod=
] and=20
> clock=3Dtsc (default). This is because of rescaling TSC pitch by cpufreq,=
 I=20
> think. If I specify in bootloader clock=3Dhpet, problem disappears. [Am I=
 doing=20
> right?]
>=20
If I boot with clock=3Dhpet the cpu MHz in cat /proc/cpuinfo is 0.

Kernel 2.6.0-tes8-bk1
IBM Thinkpad with PentiumM

                Ruben

--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/pldlgHHssbUmOEIRAsaXAKDQ8i4xTVT9jJWWs1Xk+rf1YrCsUwCfRAOH
GaLmZ6oXCyNAsgsAaFZVRc8=
=87+r
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
