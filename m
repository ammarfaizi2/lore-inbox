Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRFNIoD>; Thu, 14 Jun 2001 04:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbRFNInx>; Thu, 14 Jun 2001 04:43:53 -0400
Received: from ulima.unil.ch ([130.223.144.143]:24195 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S261577AbRFNInt>;
	Thu, 14 Jun 2001 04:43:49 -0400
Date: Thu, 14 Jun 2001 10:43:50 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Zip: what does that mean?
Message-ID: <20010614104350.A16562@ulima.unil.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have an IDE 250Mb Zip, it work fine, but I can see:
Jun 11 23:52:35 greg sudo:     greg : TTY=pts/3 ; PWD=/home/greg ;
USER=root ; COMMAND=/sbin/e2fsck /dev/hdc
Jun 11 23:52:35 greg kernel: ide-floppy: hdc: I/O error, pc = 5a, key =
5, asc = 24, ascq =  0
Jun 11 23:52:37 greg kernel:  hdc: unknown partition table
Jun 11 23:52:37 greg kernel: hdc: 98304kB, 96/64/32 CHS, 4096 kBps, 512
sector size, 2941 rpm
Jun 11 23:52:37 greg kernel: ide-floppy: hdc: I/O error, pc = 5a, key =
5, asc = 24, ascq =  0
Jun 11 23:52:37 greg kernel:  hdc: unknown partition table

Could someone explain me what's wrong?

I can access then the disk without the smallest problem.

It's with all my self compiled kernel... (2.4.n and 2.4.n-acm).

Thanks,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KHlGFDWhsRXSKa0RArEnAKDRRJicB6QggfMezzrYjUcJ28edpQCfdBzB
MQ/5taDPs8PWqibXCbv7/3Q=
=H5rG
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
