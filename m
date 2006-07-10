Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWGJVzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWGJVzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWGJVzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:55:39 -0400
Received: from altrade.nijmegen.internl.net ([217.149.192.18]:43693 "EHLO
	altrade.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id S964954AbWGJVzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:55:39 -0400
From: jos poortvliet <jos@mijnkamer.nl>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: 2.6.18-rc1
Date: Mon, 10 Jul 2006 23:58:21 +0200
User-Agent: KMail/1.9.3
Cc: Con Kolivas <kernel@kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
References: <200607101308.26291.kernel@kolivas.org>
In-Reply-To: <200607101308.26291.kernel@kolivas.org>
X-Face: $0>4o"Xx2u2q(Tx!D+6~yPc{ZhEfnQnu:/nthh%Kr%f$aiATk$xjx^X4admsd*)=?utf-8?q?IZz=3A=5FkT=0A=09=7CurITP!=2E?=)L`*)Vw@4\@6>#r;3xSPW`,~C9vb`W/s]}Gq]b!o_/+(lJ:b)=?utf-8?q?T0=26KCLMGvG=7CS=5E=0A=09z=7B=5C=2E7EtehxhFQE=27eYSsir/=7CtQ?=
 =?utf-8?q?j=23rWQe4o?=>WC>_R<vO,d]czmqWYkq[v~iB.e_GuxB'")
 =?utf-8?q?p3=0A=09jGdrhlY4=5E!vd=3F=3AegW?=)xn&fP4!FV<.
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1205434.FbitP2aLg2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607102358.25756.jos@mijnkamer.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1205434.FbitP2aLg2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op maandag 10 juli 2006 05:08, schreef Con Kolivas:
> I see the merge window closed and swap prefetch got bypassed again. I'd
> like to believe it was an oversight but far more likely that Andrew remai=
ns
> undecided about whether it should go in or not.
>
> No bug reports have come from it in 6 months, the code has remained
> unchanged for 3 months, it is as unobtrusive as a driver that is not
> compiled in when !CONFIGed and there are numerous reports from satisfied
> users (even ones that made it to the scary grounds of lkml). The only thi=
ng
> that happens is Nick keeps threatening to review it over and over and over
> and....
>
> I'm not sure what else needs to happen?

That's what I wonder about. What exactly are the criteria for getting=20
something in the kernel? People who want it, and someone willing to maintai=
n=20
it are part of it, I guess... Good design? The Right Thing, The Right Way?

Now I wouldn't say Andrew is 'nobody', and if he objects, that's something =
for=20
sure. But he doesn't even object (do you?).

I like swap prefetch, and it works for me. I can patch it in myself, so its=
=20
not all that important to me. And its just a small thing. But many small=20
things...

Jos

--nextPart1205434.FbitP2aLg2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEss2B+wgQ1AD35iwRAnaVAKC3ivuJYUsgUspHTE2H6g7xxSn69QCgulz6
uoVbDbKOhu2tZdBS2+ZjDx4=
=3IPG
-----END PGP SIGNATURE-----

--nextPart1205434.FbitP2aLg2--
