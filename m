Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTAINjP>; Thu, 9 Jan 2003 08:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266675AbTAINjP>; Thu, 9 Jan 2003 08:39:15 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10763 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S266643AbTAINjN>;
	Thu, 9 Jan 2003 08:39:13 -0500
Date: Thu, 9 Jan 2003 14:47:55 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Bug Database V1.10 on-line
Message-ID: <20030109134755.GE2529@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200301091311.h09DB4Ka001126@darkstar.example.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Content-Disposition: inline
In-Reply-To: <200301091311.h09DB4Ka001126@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-01-09 13:11:04 +0000, John Bradford <john@grabjohn.com>
wrote in message <200301091311.h09DB4Ka001126@darkstar.example.net>:
> Version 1.10 of my kernel bug database is now on-line at:
>=20
> http://grabjohn.com/kernelbugdatabase/

> If the original submitter of a bug uploaded their config file, you can
> download a config file with the same options set.

What do I get? His/her config file, or some other?

One can watch certain subsystems/drivers. That's a _really_ nice
feature, and I'd even like to be notified if a file belonging to one of
"my" choosen subsystems is to be changed on mainstream. However,
choosing subsystems of interest isn't quite fun because of the entrie's
order.

I'd do this with three parts (within one list):

ARCH - ALPHA
ARCH - SPARC
ARCH - ...

Then important subsystems:
FS-Core
INIT
NET
NET-IPv4
NET-IPv6
NET-xxx
PCI
SCSI
IDE
=2E..

=2E..and at last, I'd list all chooseable drivers:
3c509
cpuid
ACPI
APM
FS - AFS
FS - EXT2
FS - EXT3
FS - codepages
=2E..

That would really ease finding the interesting parts. Where, for
example, can I go for sparc?

MfG, JBG



--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HX2LHb1edYOZ4bsRAp+3AJ4xWnOptZUR2LV9BhF/rKmd5TBZTACggIwK
oyzhy7q61ATl2p9npYM4NQk=
=8pH9
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--
