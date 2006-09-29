Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbWI2It4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWI2It4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWI2Itz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:49:55 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:22963 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030418AbWI2Ity (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:49:54 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18 Nasty Lockup
Date: Fri, 29 Sep 2006 11:49:52 +0300
User-Agent: KMail/1.9.4
Cc: Greg Schafer <gschafer@zip.com.au>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
References: <20060926123640.GA7826@tigers.local> <1159384500.29040.3.camel@localhost> <200609281439.58755.caglar@pardus.org.tr>
In-Reply-To: <200609281439.58755.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13807620.9j1jKMBtKU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609291149.52443.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13807620.9j1jKMBtKU
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

28 Eyl 2006 Per 14:39 tarihinde, S.=C3=87a=C4=9Flar Onur =C5=9Funlar=C4=B1 =
yazm=C4=B1=C5=9Ft=C4=B1:=20
> 27 Eyl 2006 =C3=87ar 22:14 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=
=C4=B1=C5=9Ft=C4=B1:
> > Ok. Good to hear you have a workaround. Now to sort out why your TSCs
> > are becoming un-synced. From the dmesg you sent me privately, I noticed
> > that while you have 4 cpus, the following message only shows up once:
> >
> > ACPI: Processor [CPU1] (supports 8 throttling states)
> >
> > Does disabling cpufreq change anything?
>
> By the way i tried but nothing changes :(

Is there any other advice available? Is there anything else you want me to=
=20
try?

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart13807620.9j1jKMBtKU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFHN4wy7E6i0LKo6YRAiqwAJ449f0z1h39g+BdFTrrmAuCV5QNEwCeKj30
zSFYJmlHVVNQTdv1owxnsO0=
=NAnq
-----END PGP SIGNATURE-----

--nextPart13807620.9j1jKMBtKU--
