Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131037AbQLTCqZ>; Tue, 19 Dec 2000 21:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131036AbQLTCqQ>; Tue, 19 Dec 2000 21:46:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:56588 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131017AbQLTCqB>;
	Tue, 19 Dec 2000 21:46:01 -0500
Date: Wed, 20 Dec 2000 03:13:32 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: DC390/tmscsim-2.0f SCSI driver released
Message-ID: <20001220031332.C27881@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I finally finished to fix bugs WRT kernel 2.4 of the=20
Tekram DC390 / AM53C974 / tmscsim SCSI driver.
Therefore, I released the version 2.0f, which you may find on
http://www.garloff.de/kurt/linux/dc390/
ftp://ftp.suse.com/pub/people/garloff/linux/dc390/

The driver should work better than ever since with both 2.2 and 2.4=20
kernels. (Maybe even 2.0, I didn't test.)
I'd be glad to get some feedback. If it's positive, I'll ask Alan and
Linus to put it into the mainstream kernel.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6QBXMxmLh6hyYd04RAokVAKCYgHQPi3gOxZ5Q4X9jRXNCUfwu4QCgys5t
sGUstIIz2MPzte/8tjPr7/8=
=s0x9
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
