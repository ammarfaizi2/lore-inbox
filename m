Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135738AbRDVImX>; Sun, 22 Apr 2001 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135705AbRDVImN>; Sun, 22 Apr 2001 04:42:13 -0400
Received: from ulima.unil.ch ([130.223.144.143]:11014 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S135517AbRDVImJ>;
	Sun, 22 Apr 2001 04:42:09 -0400
Date: Sun, 22 Apr 2001 10:42:06 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: rmmod take all CPU and I can't stop it under 2.4.3-ac{9,11}
Message-ID: <20010422104206.A2939@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am using DVB and sometimes I have to reload the driver, some times, I
can just do it without problem, but often, it result in a (from top):
 1359 root      19   0   532  532   360 R    77.7  0.2   8:32 rmmod

And a kill -KILL 1359 has no effect at all?

Is there a way to kill that jobs?

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE64pleZZVeVjNKmG0RAjvYAJ9iN4+05nIahFBB2fxFDShqY1CWxwCeND1u
vJDOmEBK+lDEoSqtZaLnC/c=
=8yFK
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
