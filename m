Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRCBPia>; Fri, 2 Mar 2001 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRCBPiL>; Fri, 2 Mar 2001 10:38:11 -0500
Received: from [212.6.145.2] ([212.6.145.2]:29961 "HELO heaven.astaro.de")
	by vger.kernel.org with SMTP id <S129250AbRCBPiH>;
	Fri, 2 Mar 2001 10:38:07 -0500
Date: Thu, 1 Mar 2001 18:41:59 -0800
From: Daniel Stutz <dstutz@astaro.de>
To: linux-kernel@vger.kernel.org
Subject: Broken APM Support since 2.4.1-ac1
Message-ID: <20010301184159.A663@mukmin.astaro.de>
Reply-To: Daniel.Stutz@astaro.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Astaro AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

APM support for Lifebook C 6185 is broken since 2.4.1-ac1.
While trying to go in suspend mode the system hangs.

It works fine in 2.4.1, so I think it's not the fault of the bios.

The last version I tried is 2.4.2-ac5

Daniel

--=20
--
In God we Trust, all others please submit signed PGP/X.509 key
Daniel Stutz <Daniel.Stutz@astaro.de>    | Product Development
Astaro AG | http://www.astaro.de  | +49-721-490069-0 | Fax -55

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1e-SuSE (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEXAwUBOp8Id0vYZOFi63MrFAPzLQP+NfH21an44ZhVWPm94cQ/pTwex07TjnO1
jnYq7EpSUy5ISZJw1FpP7zjuOrA1TRbLA4dxzHRWdPIwPRuXwO/qJfMLbXuaSJOQ
rBIx+T8ptSm62Yyn9lCwC8X76RXlxw10c2VZ4IOvej76LKFuYyqZAc+FZvdn1f03
TC3TGFal+psEAKd4HC4vtmCL7DHBOFOu4Qzcf2PL+MADEi+jnOU1FfV3pzdc0rRc
643ZQEmpWf3fctnUn54tD9NmZKHRGXPpcu0eZEOZ5RwOB3A9YG0a+r9TbpLOtvZA
jbsm/Cbfx+F+HVnSRiu4/jHcxtujFavdVYkpow7O4nr4ktCpw98mmL1l
=kzT7
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
