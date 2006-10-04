Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWJDNi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWJDNi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWJDNi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:38:26 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:49582 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030388AbWJDNiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:38:25 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [Ops] 2.6.18
Date: Wed, 4 Oct 2006 16:38:25 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
References: <200610010332.52509.caglar@pardus.org.tr> <1159810605.5873.4.camel@localhost.localdomain>
In-Reply-To: <1159810605.5873.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4364652.Y2UUrnJvcz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610041638.25955.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4364652.Y2UUrnJvcz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

02 Eki 2006 Pts 20:36 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> On Sun, 2006-10-01 at 03:32 +0300, S.=C3=87a=C4=9Flar Onur wrote:
> > Hi;
> >
> > Here [1] are the two different panics with 2.6.18 on vmware, its
> > reproducable on every 4-5 reboot [same config/kernel in "2.6.18 Nasty
> > Lockup" thread, so i CC'd to that thread's posters also]
> >
> > [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/
>
> Hmmm.. That first oops looks interesting to me.
>
> When you say they're reproducible every 4-5 reboots, which one do you
> mean?

=46or every 10 reboots first one occurs at least 6 times, 3 times second on=
e=20
occurs and for last it boots :)

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart4364652.Y2UUrnJvcz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFI7lRy7E6i0LKo6YRAt4GAKC4ZKxRdhU0k4DG+yu7oeRMVc7qtwCfWR+i
fU0YkgC5xnVgLM8Gjyo0BI4=
=FjpB
-----END PGP SIGNATURE-----

--nextPart4364652.Y2UUrnJvcz--
