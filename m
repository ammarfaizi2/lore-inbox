Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbTHNWpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271203AbTHNWpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 18:45:38 -0400
Received: from ns.schottelius.org ([213.146.113.242]:11904 "HELO
	schottelius.org") by vger.kernel.org with SMTP id S271156AbTHNWpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 18:45:36 -0400
Date: Thu, 14 Aug 2003 15:19:38 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0test3: scsi/net
Message-ID: <20030814131936.GA7574@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.5.72
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

scsi:
   why is 3ware ide controller still listed under the SCSI section?
   other ide raids are under the ide menu, too.
  =20
   should fusion mpt not be moved to the scsi section, too?
   (as far as I understood mpt it looks like that...)

net:
   what about a new point 'virtual network devices' for tun/tap/bonding/eql=
 ?

   why are Xircom CardBus not under removeable/pcmcia devices?


Nico
=20


--=20
echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/O4xnzGnTqo0OJ6QRAguBAJ9LG94tVEEzURQ+LI2sJgU7bSWOCgCfUdl6
F289gWFLD5KkgSE1cpLqHiA=
=yOcY
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
