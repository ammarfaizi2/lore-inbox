Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTLAVMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTLAVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:12:15 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:39831 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S264155AbTLAVLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:11:41 -0500
Subject: [OT] Rootkit queston
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iCuwvtIj8D1ZCV+1Ykpm"
Message-Id: <1070313094.11356.6.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Dec 2003 23:11:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iCuwvtIj8D1ZCV+1Ykpm
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello all!

I've been wondering about what is a rootkit and how it works?

I've been paranoid after I heard that the debian project got
"rootkitted", I ran chkrootkit, and it said that it's possible that I
have a LKM rootkit installed, but the website told me that it's possible
that the LKM test gives wrong information with recent kernels (Running
2.4.22 now).

These processes "were hidden from ps command":
root         0  0.0  0.0     0    0 ?        SWN  Oct28   0:01
[ksoftirqd_CPU0]
root         0  0.0  0.0     0    0 ?        SW   Oct28   4:27 [kswapd]
root         0  0.0  0.0     0    0 ?        SW   Oct28   0:00 [bdflush]
root         0  0.0  0.0     0    0 ?        SW   Oct28   0:01
[kupdated]

They seem to have PID 0, is this normal? Do my system have a rootkit
installed? If it does, how do I remove it?

Or, am I just paranoid?

Thanks for your time.
Regards,
Markus
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-iCuwvtIj8D1ZCV+1Ykpm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/y66F3+NhIWS1JHARAhzsAKCV4y/hlT3XVruyESPs6B7+1nF/UwCfWywu
sxhJ22uN9k7YkLX0KDVInuo=
=tPU7
-----END PGP SIGNATURE-----

--=-iCuwvtIj8D1ZCV+1Ykpm--

