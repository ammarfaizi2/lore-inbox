Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268641AbRG3WQ1>; Mon, 30 Jul 2001 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbRG3WQS>; Mon, 30 Jul 2001 18:16:18 -0400
Received: from TK212017114173.teleweb.at ([212.17.114.173]:56326 "HELO
	tk212017114173.teleweb.at") by vger.kernel.org with SMTP
	id <S268641AbRG3WQJ>; Mon, 30 Jul 2001 18:16:09 -0400
Date: Tue, 31 Jul 2001 00:19:07 +0200
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tulip driver still broken
Message-ID: <20010731001907.A21982@hostmaster.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My genuine digital network interface card ceased to work with the tulip
driver contained in kernel revisions >=3D 2.4.4 and the development driver =
from
sourceforge.net.

It seems that the driver incorrectly configures the card for full duplex mo=
de
and I could not figure out how to override this with the new MODULE_PARM
macro.

I am now using the stable driver 0.9.14 from sourceforge.net which works fi=
ne.

Further information available by request!

Tom

Quantum Mechanics is God's version of "Trust me."
--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia

iQEVAgUBO2XdWmD1OYqW/8uJAQHgQwgAiT2K8QMxr0tNdzRzvcItDwZ+DyL1RTxu
q+eHBBSp7v6lFfB2uMJfhAMmSRK6CWUppv4BM3xbIIyf9jrBXHPVzv/CNXuHAeiD
hHRAUK/P4miKSjOTrWqgzr1qdcWVhj2i5BWXPFNIqCznvGGnCfwk10R4MAW2wUwi
H2IXzBioWCpQ2KV3LprDARoEfu3YcCO+8heiOS+9q8CgGdrygkcyuHQMzUz9//0Q
1xtTojxaoES5xu2jTEkrZhkfkndhGVFGPdsQSu1e8XRDBmTEPPPpzNsCyGp9oQU5
hnM7tzUpP02bQyNzFqdqE0+qoB5YRQ3/IrnBaVkCKLlVPHh528pE5A==
=GNQV
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
