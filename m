Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277944AbRJIUE7>; Tue, 9 Oct 2001 16:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277946AbRJIUEt>; Tue, 9 Oct 2001 16:04:49 -0400
Received: from jak-fw.mendelu.cz ([195.178.73.243]:60412 "EHLO v0jta.net")
	by vger.kernel.org with ESMTP id <S277944AbRJIUEl>;
	Tue, 9 Oct 2001 16:04:41 -0400
Date: Tue, 9 Oct 2001 22:05:02 +0200
From: Robert Vojta <vojta@pharocom.net>
To: seth goldberg <seth.goldberg@Sun.COM>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: sis900 does not work in 2.4.10
Message-ID: <20011009220502.A18657@ipex.cz>
In-Reply-To: <3BC3569C.AF959299@Sun.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <3BC3569C.AF959299@Sun.COM>
User-Agent: Mutt/1.3.18i
X-Company: Pharocom, s.r.o. 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>   I just upgraded to the ECS K7S5A Athlon M/B (SiS-735 based) and was
> trying to get the onboard SiS900 ethernet adapter working.  It works
> fine on 2.4.5, but when I try to get it going under 2.4.10, the only
> thing I see happening is the number of xmit dropped increases in
> ifconfig and dmesg revels a NETDEV WATCHDOG transmit timeout:

  I have the SiS900 ethernet adapter in my laptop and now, I'm compiling
2.4.10-ac10, so I will write you after several minutes if it works here or
not ...

                                                            --Robert V0jta

--=20
    Robert Vojta <vojta at {pharocom.net - work | v0jta.net - private}>
          GPG: ID 1024D/A0CB7953            http://www.v0jta.net/=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvDWG4ACgkQInNB3KDLeVO7LACdHvfB0uBrmHmFiA5R7SRqmKbQ
Y2YAn0IX5tC0DB8YxP1MyTi1MLo2Wwyr
=VDC7
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
