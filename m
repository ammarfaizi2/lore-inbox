Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWKERRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWKERRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWKERRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:17:55 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:38108 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161382AbWKERRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:17:54 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Andi Kleen <ak@suse.de>
Subject: Re: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 19:17:53 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de>
In-Reply-To: <200611051740.47191.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2003170.6GiiUraA7Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611051917.56971.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2003170.6GiiUraA7Y
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=B1=C5=
=9Ft=C4=B1:=20
> How do you know this?

Just guessing, if im not wrong panics occur after SMP alternative switching=
=20
code done its job.

> And does it still happen in 2.6.19-rc4?

Will try

> > in VmWare and Microsoft Virtual
> > PC and in order to confirm this bug is not our distro specific i
> > downloaded and tried latest OpenSuse also [1]  and [2] are screens
> > captured by vmware but exact same panic occurs in Virtual PC as reported
> > to us in [3].
>
> Always the same BUG()?

Yes, same bug

> There is just some rolling Turkish text there.

Ah im sorry here is the correct links :(

[1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic_on_opensuse.png
[2] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic_on_pardus.png

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2003170.6GiiUraA7Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFThzEy7E6i0LKo6YRAkZlAKCMpKUCsHHavGRkp3NxduuZ+aroVACgiBGj
mcfIRaStoITXyQ2X2U+9SHI=
=12dg
-----END PGP SIGNATURE-----

--nextPart2003170.6GiiUraA7Y--
