Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161537AbWJDQIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161537AbWJDQIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161539AbWJDQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:08:16 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:61402 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161537AbWJDQIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:08:15 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Andi Kleen <ak@muc.de>
Subject: Re: [Ops] 2.6.18
Date: Wed, 4 Oct 2006 19:08:14 +0300
User-Agent: KMail/1.9.4
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200610010332.52509.caglar@pardus.org.tr> <200610041638.25955.caglar@pardus.org.tr> <20061004144736.GA67993@muc.de>
In-Reply-To: <20061004144736.GA67993@muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3299234.vbUYLaJZvQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610041908.20822.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3299234.vbUYLaJZvQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

04 Eki 2006 =C3=87ar 17:47 tarihinde, Andi Kleen =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:=20
> > For every 10 reboots first one occurs at least 6 times, 3 times second
> > one occurs and for last it boots :)
>
> I assume it must be something specific to your configuration
> or setup.
>
> If plain 2.6.18 was that unstable we would be flooded in reports.
> But that's not the case.  I also definitely don't see it on any of my
> systems (except that if you use PIT time source on a multi core system
> things break on i386)

I think you misunderstand me or i cant explain well :(, plain 2.6.18 boots =
on=20
these system without a problem but same kernel in vmware oopses. Of course=
=20
this can be a just a vmware problem but i can reproduce this behaviour (sam=
e=20
kernel boots real system but oopes in vmware with same output) with 3=20
different normal desktop PC's and two different vmware server version.

> Perhaps you list your setup and your configuration and a boot log
> for the working case?=20

Ok, I'll send all configurations and logs

> I also I would really recommend to do the make=20
> distclean ; recompile step I mentioned earlier.

Ok, I'll listen you and will recompile asap:)

Cherrs
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart3299234.vbUYLaJZvQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFI9x0y7E6i0LKo6YRAgjwAJ4oT4y4D4qs9+LlgKaseeX85AswlACfe5Ei
MwlP6yJPajcQmlm9Xj0VisM=
=CaAn
-----END PGP SIGNATURE-----

--nextPart3299234.vbUYLaJZvQ--
