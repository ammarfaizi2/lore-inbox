Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129809AbQK1KRC>; Tue, 28 Nov 2000 05:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129946AbQK1KQx>; Tue, 28 Nov 2000 05:16:53 -0500
Received: from mario.gams.at ([194.42.96.10]:24686 "EHLO mario.gams.at")
        by vger.kernel.org with ESMTP id <S129809AbQK1KQg>;
        Tue, 28 Nov 2000 05:16:36 -0500
Message-Id: <200011280946.KAA25036@frodo.gams.co.at>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Bernd Petrovitsch <bernd@gams.at>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About IP address 
In-Reply-To: Your message of "Mon, 27 Nov 2000 16:32:17 EST."
             <20001127163217.B20394@alcove.wittsend.com> 
X-Url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1628692572P";
         micalg=pgp-md5; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Nov 2000 10:46:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1628692572P
Content-Type: text/plain; charset=us-ascii

To throw additional information (or confusion or simply wrong stuff?) in :

In message <20001127163217.B20394@alcove.wittsend.com>, "Michael H. Warfield" w
rote:
>	I have been unable to find any documentation in the RFCs
>which lay claim to restricting 128.0.*.* or 191.255.*.*.  The fact

RFC1940, though it's "only" informational, bottom of page 7  :
--- snip ---
      Source Route (variable)

         The components of the source route are syntactically IP
         addresses.

         An IP address from network 128.0.0.0 is used to encode a next
         hop that is a domain.  The least significant two octets contain
         the DI, which is an Internet Autonomous System number.
--- snip ---

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
G.A.M.S GmbH                                  Fax : +43 1 8958499-60
Stiegerg. 15-17/8                       A-1150 Vienna/Austria/Europe
                     LUGA : http://www.luga.at



--==_Exmh_-1628692572P
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

owF9VEGLHEUU3lUDZmAwKAgiymM9mKwzNd2zM7szo8ZM4maz6ELMbvRc0/26u7C7
qql6tT1zMB4MSE7G/AMvXjysKEhOHjzIIvgTJCh40fwIX+0mMArm1aVe9Xtffd9X
jz56Zp3ORaJyuegPNsdjgfOqmLx26+EVowk1dQ8WNU6AcE69upRKvwlJIa1Detu7
rnSJUu1Wu3VggAprGpBpqkgZLUtQOjO2kiGD88ZCYnTmXcg4caqqywU01ugcHPks
e+cCd8AkoO1qqNA5mSO81Y+iKI77W/HmRj/eEpf70cZ4cEmWiTlE0SgihzoViaku
dmBtTzE5LOGagI+kzRSW6Ro07ZY1hIx88ewuFPIQYYaowWs5KxHIQKZ0ClIvIDWJ
r1j1KWmmQwXCjatXHPc2BYNDKReQsA9V6LPoyKqEFGuI+yMRiXWxHtTF41j0h8OQ
CoADBslkQkEag8XjQdRhZOPzAhS97mDN6HKxtmyYLDswM0SmApNBHZzYgmBOt9sF
p1UNvGm34CT2jbcJ8zSeEM4fSquCsAvhOngcgQObVBvN8lwADdLcaac96ZSWDxYs
ngUlsuTX2b2+hMAvy3odOvEv4KnmsscfIbPMWCM1xn78yBJeoBx4h2nwDHViUr6M
q+a0hFOYmilJCrWSH6LiWXvkXYnSEU9MrlXGzDQB44NJCFkJTxVx6RJSEPbubgdO
HyzAMUUeZsu8YOrJaFMZ72B/4QiZra9maMV/rW23zl7mljSct1snW7iOZM2hIse4
T4xtZl/ChOeM2y7lsnJCstgdMRV7Yh92qtm1JwOEuCrnDPHGYANiGI2Ho8F43N2M
2q19UpijzQXEw2681Rv9T/+0G8fDCD5UqLXsTX2YVdnb9tbUuGTXcrx/c2fKdxZE
9aTXa5pGlD6XJ9zDWlm5s3Lz6TOr4f9w9PePP/z53N7q6uoLt59a+e7Bg1duffDT
8f3e959t/3p89Ok3X1e//Xz80i/i7vPTG3/ZL+JvG6rvvXr/k4fn3hv9jrdf/vzL
Z++86M/80Zn7r+7e+wc=
=/Uao
-----END PGP MESSAGE-----

--==_Exmh_-1628692572P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
