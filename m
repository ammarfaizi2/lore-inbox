Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRCBPik>; Fri, 2 Mar 2001 10:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRCBPia>; Fri, 2 Mar 2001 10:38:30 -0500
Received: from [212.6.145.2] ([212.6.145.2]:30473 "HELO heaven.astaro.de")
	by vger.kernel.org with SMTP id <S129249AbRCBPiN>;
	Fri, 2 Mar 2001 10:38:13 -0500
Date: Fri, 2 Mar 2001 16:16:15 -0800
From: Daniel Stutz <dstutz@astaro.de>
To: linux-kernel@vger.kernel.org
Subject: Broken APM Support in 2.4.X
Message-ID: <20010302161615.A572@mukmin.astaro.de>
Reply-To: dstutz@astaro.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Astaro AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

I'm using a Lifebook C 6185 with kernel 2.4.1 (unpatched).

Power Management is working fine in this version, but in all other versions
from 2.4.1-ac1 till 2.4.2-ac8 the systems hangs if it goes to suspend mode.

Is this a known issue?=20

If not, I am a kernel hacking virgin, but if anyone could give me a hint, I
would try to fix this behavior.

Thanks in advance.

Daniel

--=20
--
In God we Trust, all others please submit signed PGP/X.509 key
Daniel Stutz <Daniel.Stutz@astaro.de>    | Product Development
Astaro AG | http://www.astaro.de  | +49-721-490069-0 | Fax -55

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1e-SuSE (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEXAwUBOqA3z0vYZOFi63MrFAMr+QP8CSU8V7gm5YSQ5cJIGOHKB2LTqeBTAZTW
wrReoS/TJKYfz/KMBj6UPvKs2WNiuK0j3The3mKbLCKbuA4cWqZSZJ/dUL6OuGRq
JsBp9Fl/A4XZJCBdPBdPAKPP6taSp3DbcGefE/BjrloiekjZsLjCTiqqSscx1I1e
wbFRKfy49nsD/0f7NWgAE4jI5aSqlCHGE/MkONue1MCoejRTzqtmyFS348oEvBlK
jRXHqLmbbPUncxfcC9IU2yZd0wTkXAhEDPxA8W0SRyCnbKATRLvCcx25MWhxsuWr
xStVSPdV5t8Esn2xwzuG7p//xKnuAgpvDDrkXutFKy6GO3SjlCV2Jk1t
=6g/o
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
