Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWJKTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWJKTIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWJKTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:08:53 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:64918 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932467AbWJKTIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:08:52 -0400
From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Wed, 11 Oct 2006 22:08:57 +0300
User-Agent: KMail/1.9.5
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1246475.5mlQKEE5qL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610112208.57136.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1246475.5mlQKEE5qL
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

11 Eki 2006 =C7ar 22:00 tarihinde, Pallipadi, Venkatesh =FEunlar=FD yazm=FD=
=FEt=FD:=20
> I guess I misunderstood the original issue. You have available_frequencies
> showing all the values and after you load ondemand, frequency remains at
> the highest, even though CPUs are idle. Is this correct?

Yes, thats the originial issue, no freq. changes at all.

> And everything above used to work fine with 2.6.16?

Yes, everything works fine with 2.6.16.

> Can you configure with CPU_FREQ_DEBUG and do "echo 5 >
> /sys/module/cpufreq/parameter/debug" before switching the governor to
> ondemand and see whether you see any messages in dmesg?

I'll and report back.

Cheers
=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1246475.5mlQKEE5qL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLUFJy7E6i0LKo6YRAtfvAJ92QvU+JX2Fs2mtHrn/fcQa3ofuawCdHO8E
/K3vS0UwHoF5YPfuICxsEWo=
=7qdG
-----END PGP SIGNATURE-----

--nextPart1246475.5mlQKEE5qL--
