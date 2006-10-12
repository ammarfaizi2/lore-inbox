Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422797AbWJLHpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWJLHpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWJLHpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:45:54 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:33166 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1422797AbWJLHpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:45:30 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Thu, 12 Oct 2006 10:45:32 +0300
User-Agent: KMail/1.9.5
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <1160592235.5973.5.camel@localhost.localdomain> <452DEEAB.3000403@suse.de>
In-Reply-To: <452DEEAB.3000403@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3834405.PnYAM9yUOX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610121045.32846.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3834405.PnYAM9yUOX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

12 Eki 2006 Per 10:28 tarihinde, Gerd Hoffmann =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> Try switching the vmware configuration to "other OS".  This turns off
> os-specific binary patching.  The alternatives code might have broken
> assumptions vmware does about the linux kernel code ...

I did before, i tried these combinations

* Guest Os: Linux, Version: Other Linux 2.6.x kernel
* Guest Os: Linux, Version: Other Linux
* Guest Os: Other, Version: Other

all of them ends up with panic.

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3834405.PnYAM9yUOX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLfKcy7E6i0LKo6YRAlQSAJ9/UY3YeJlnhXkaN3sjDpifeJgaRQCgp4//
tx6yn1S2A8AegRMhaEYYpNU=
=ehzO
-----END PGP SIGNATURE-----

--nextPart3834405.PnYAM9yUOX--
