Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUL3Myi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUL3Myi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 07:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUL3Myi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 07:54:38 -0500
Received: from hs-grafik.net ([80.237.205.72]:18869 "EHLO
	ds80-237-205-72.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id S261623AbUL3Myg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 07:54:36 -0500
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG in reiser4
User-Agent: KMail/1.7.1
References: <200412291939.31032@zodiac.zodiac.dnsalias.org> <1104407116.3682.168.camel@tribesman.namesys.com>
In-Reply-To: <1104407116.3682.168.camel@tribesman.namesys.com>
X-Need-Girlfriend: always
X-Ignorant-User: yes
MIME-Version: 1.0
Date: Thu, 30 Dec 2004 13:54:33 +0100
Content-Type: multipart/signed;
  boundary="nextPart3771948.7tJEC1PUso";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412301354.34151@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3771948.7tJEC1PUso
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 30. Dezember 2004 12:45 schrieben Sie:
> It is very likely that this biug is fixed already in
> ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.10-rc3-mm1/reiser4-update-f=
or
>-2.6.10-rc3-mm1-1.gz
>
> Would you try it, please?

Seems to work, I cannot reproduce the bug.
Sorry for not running the latest version, seems I have overlooked the fix..

Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

--nextPart3771948.7tJEC1PUso
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB0/qK/aHb+2190pERAjI8AKCWGyIAqD2AJQ94XODXpBtPI2U/YQCfZ5CV
exKa5NTTqLgo+yue87Z0Wfc=
=+ZZr
-----END PGP SIGNATURE-----

--nextPart3771948.7tJEC1PUso--
