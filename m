Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDPWIc>; Mon, 16 Apr 2001 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDPWIW>; Mon, 16 Apr 2001 18:08:22 -0400
Received: from p198.as-l002.contactel.cz ([212.65.195.198]:37877 "HELO
	SnowWhite.SuSE.cz") by vger.kernel.org with SMTP id <S132338AbRDPWIF>;
	Mon, 16 Apr 2001 18:08:05 -0400
To: Rajeev Nigam <rajeev.nigam@dcmtech.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Port Communication
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A017AEBD7@dcmtechdom.dcmtech.co.in>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A017AEBD7@dcmtechdom.dcmtech.co.in> (Rajeev Nigam's message of "Mon, 16 Apr 2001 18:35:54 +0530")
Message-ID: <m3y9t0lgoq.fsf@SnowWhite.Janik.cz>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: 17 Apr 2001 00:09:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

   From: Rajeev Nigam <rajeev.nigam@dcmtech.co.in>
   Date: 	Mon, 16 Apr 2001 18:35:54 +0530

Hi,

   > How can I write to, read from the com port. I have linux 6.2 and kernel
   > 2.2.14 version.

there is no Linux with that version number. Upgrade your kernel.

   > Is anybody having a sample code which is performing these operation
   > including Open and Close com port, Pls send me.

See Serial-Programming HOWTO or any other *user*space program. Do not do
serial stuff in the kernel itself.
=2D-=20
Pavel Jan=EDk

You should stop smoking that stuff, really.
                  -- Robin S. Socha to Lars Magne Ingebrigtsen (of Gnus fam=
e)
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Public key is available on http://www.janik.cz/pgp/

iD8DBQE621lIl/ao7ZNClncRAnXKAKCvCNssjmfoJ/9jPCz0Fm3u0eeH7QCdGmao
zHrbbrGrbb21dboeIX7cV48=
=HkqI
-----END PGP MESSAGE-----
--=-=-=--
