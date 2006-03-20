Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWCTTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWCTTIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWCTTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:08:37 -0500
Received: from wg.technophil.ch ([213.189.149.230]:23957 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S964975AbWCTTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:08:34 -0500
Date: Mon, 20 Mar 2006 20:08:22 +0100
From: Nico Schottelius <nico-kernel-20060320@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: OT: Download the latest kernel
Message-ID: <20060320190822.GA16943@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel-20060320@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.15.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Just or those beeing lazy like me, there's a small script, which
retrieves the latest kernel via http using wget [0].

You can use it after you read about the latest kernel [1].

In theory one could also use wget -c to and then put the script under
control of cron, but wget has no
'--do-not-say-something-if-file-is-already-there-and-complete' switch,
so it will always tell you that the file is already there.

Nico

[0]: http://linux.schottelius.org/scripts/#get-latest-kernel
[1]: http://lists.schottelius.org/kernel-announce.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRB79prOTBMvCUbrlAQK4aw//dEcAsTvH09i1qIkpbeUoU50efc6FFnA9
irgtoq0IAd6jfPxehRZcppezPIZXlPi6NQmnv5AaxjgxRpTROaqQKQ6r1Vo8Vwzi
tT8ucIMg86C1B6DET9xE5hK/0QnxZBYcNA+voAdtMvs8s3eFmVHaSx8Wufv3nCFT
aFx2DPKbKLB/z/jYKyx4y5Jjb0d8i/sClGqLlfva8W61ikgzAptDZLWS5SxS0rbD
tC2ExaS3SdhqJXuZfzqv0A3oOEL1I5lhN7vNlwkY8l6n96uIhiSi6uwG/GkCzn7E
s0IxslhrGU/Ry5YBuIIDdJmgpKBnerSKwmsCcIoWUocJIkmcxrHe42PEpBCnP/es
bK03evN/D+ZgiKIQA5MmDF6zeN2luUlVPRCCyzmQ3VRiDiAJCK1p2m0VX1iGgdBS
Pr92tYkRUUfgn/F/MZKutmGnjXBRxfY18+95zsgMaarGze4mwWhijMETliUGLJ0y
kNRTZlw7b1nWCT/1FC4f4ZJiDuRLjKoFYI/0mJQa/pLUuNkshX0p957WbOoePS+1
2vp2xAyhUmconr8vHucYRBKi7oIo9bmdDFcpnwuqsIQopg5isLnO8cExdo4oWD3M
gaKQCHqVfWBUO1jMB1voocf/iMXewp/mpjEHNQkwyynjDH72rwYuXLJPgKbz5Ck5
yYXEapwz3LU=
=J1tG
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
