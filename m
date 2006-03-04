Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWCDGf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWCDGf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 01:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCDGf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 01:35:26 -0500
Received: from mail.goelsen.net ([195.202.170.130]:3223 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751390AbWCDGfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 01:35:25 -0500
From: Michael Monnerie <m.monnerie@zmi.at>
Organization: it-management http://zmi.at
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Sat, 4 Mar 2006 07:34:41 +0100
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Allen Martin <AMartin@nvidia.com>,
       Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48CCB0@hqemmail02.nvidia.com> <200603032312.13369.ak@suse.de> <4408C1E1.7090006@pobox.com>
In-Reply-To: <4408C1E1.7090006@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3436171.g4Jq9bMaOy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603040734.46091@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3436171.g4Jq9bMaOy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Freitag, 3. M=E4rz 2006 23:23 Jeff Garzik wrote:
> I'll happen but not soon. =A0Motivation is low at NV and here as well,
> since newer NV is AHCI. =A0The code in question, "NV ADMA", is
> essentially legacy at this point -- though I certainly acknowledge
> the large current installed base. =A0Just being honest about the
> current state of things...

I'd like to raise motivation a lot because most MB sold here (central=20
Europe) are Nforce4 with Athlon64x2 at the moment. It would be nice=20
from vendors if they support OSS developers more, as it's their=20
interest to have good drivers.

=46or the moment, I'd recommend *against* using Nforce4 because of that=20
problems we had (and that caused us a lot of unpaid repairing work).=20
Hopefully NV does something quick to resolve the remaining issues,=20
especially as the 4GB "border" is hit more and more often.

mfg zmi
=2D-=20
// Michael Monnerie, Ing.BSc  ---   it-management Michael Monnerie
// http://zmi.at           Tel: 0660/4156531          Linux 2.6.11
// PGP Key:   "lynx -source http://zmi.at/zmi2.asc | gpg --import"
// Fingerprint: EB93 ED8A 1DCD BB6C F952  F7F4 3911 B933 7054 5879
// Keyserver: www.keyserver.net                 Key-ID: 0x70545879

--nextPart3436171.g4Jq9bMaOy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBECTUGORG5M3BUWHkRAvP9AJ4w/p3LjmsPOf3Eic6nZzgGP87NiwCZAWl0
jkPCoTDYWdpdjnHC/ugdVt8=
=CDn4
-----END PGP SIGNATURE-----

--nextPart3436171.g4Jq9bMaOy--
