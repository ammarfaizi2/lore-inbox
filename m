Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWJKKt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJKKt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 06:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWJKKt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 06:49:29 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:28301 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751179AbWJKKt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 06:49:28 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Wed, 11 Oct 2006 13:49:31 +0300
User-Agent: KMail/1.9.5
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610101211.48757.caglar@pardus.org.tr> <1160504865.4973.8.camel@localhost>
In-Reply-To: <1160504865.4973.8.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1205079.NxVGrixvJK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610111349.32231.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1205079.NxVGrixvJK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

10 Eki 2006 Sal 21:27 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1:=20
> On Tue, 2006-10-10 at 12:11 +0300, S.=C3=87a=C4=9Flar Onur wrote:
> > 07 Eki 2006 Cts 00:38 tarihinde, john stultz =C5=9Funlar=C4=B1 yazm=C4=
=B1=C5=9Ft=C4=B1:
> > > S.=C3=87a=C4=9Flar: Could you give it a whirl to see if it changes yo=
ur vmware
> > > issue?
> >
> > Nothing changes inside the vmware, same panics occured as like before :(
>
> Hmm.. Did you manage to grab the full log?

Yep, [1] here is whole screen and used config, and as andi suggested i=20
recompiled this kernel [pure vanilla 2.6.18] from scratch.

[1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/

=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1205079.NxVGrixvJK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLMw8y7E6i0LKo6YRAv/IAKCrn0avFmahsIeUf0wU9obSJJ8NagCfUva0
hCU4fZImyah1WCBhaMCoQIM=
=x2RU
-----END PGP SIGNATURE-----

--nextPart1205079.NxVGrixvJK--
