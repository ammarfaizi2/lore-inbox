Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136711AbREAUFC>; Tue, 1 May 2001 16:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136707AbREAUEv>; Tue, 1 May 2001 16:04:51 -0400
Received: from ulima.unil.ch ([130.223.144.143]:46349 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S136708AbREAUEf>;
	Tue, 1 May 2001 16:04:35 -0400
Date: Tue, 1 May 2001 22:04:32 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Cc: linux-dvb@linuxtv.org, cooker@linux-mandrake.com
Subject: Still hudge sound problem on 2.4.4-ac2
Message-ID: <20010501220432.A18201@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org,
	cooker@linux-mandrake.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I don't know what have changed since 2.4.4-pre6 or 2.4.3-ac13 which are
the last kernel I had tested before 2.4.4 which introduced that sound
problem...

I have a sound card, but I don't load the modules for it: I just use=20
my DVB-s card from Hauppauge to watch TV or playing DVD.

It seems that's watching TV works, but I haven't tested it more than 20
minutes long, but when playing a DVD, in the best case, one could hear a
good sound during ten minutes, and then there is so much noise that one
could not hear anything at all?

What could I say more? Maybe lspci:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (r=
ev 02)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev=
 02)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (re=
v 05)
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
00:0a.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 0=
6)
00:0c.1 Input device controller: Creative Labs SB Live! (rev 06)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev =
04)

And gcc -v:
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux/2.96/specs
gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.49mdk)

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67xbQFDWhsRXSKa0RAhmnAJ9pZzXYYWb1gK6x6qc6XUhbeZE3LgCgmnYb
OUlE1KfKF6WL8NuBn3jPH7s=
=3qwJ
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
