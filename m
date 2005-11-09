Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVKIPnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVKIPnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKIPnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:43:41 -0500
Received: from onyx.ip.pt ([195.23.92.252]:63882 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S1751328AbVKIPnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:43:40 -0500
Subject: Re: New Linux Development Model
From: Marcos Marado <marado@isp.novis.pt>
Reply-To: marado@isp.novis.pt
To: Calin Szonyi <caszonyi@rdslink.ro>
Cc: jerome lacoste <jerome.lacoste@gmail.com>,
       Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0511091547080.15950@grinch.ro>
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org> <436CB162.5070100@ed-soft.at>
	 <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
	 <436DEEFC.4020301@ed-soft.at>
	 <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
	 <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
	 <5a2cf1f60511090430y63db5473we40f077070ecb43a@mail.gmail.com>
	 <Pine.LNX.4.62.0511091547080.15950@grinch.ro>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ANSTIyqBw5h9mUp8dt18"
Organization: Novis ISP
Date: Wed, 09 Nov 2005 15:45:04 +0000
Message-Id: <1131551104.8930.48.camel@noori.ip.pt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ANSTIyqBw5h9mUp8dt18
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 16:03 +0200, caszonyi@rdslink.ro wrote:
> On Wed, 9 Nov 2005, jerome lacoste wrote:
> Because i like to test new kernels. On 2.4 I run the vanila kernel and a=20
> test kernel. When something went wrong on a test kernel was always a=20
> stable kernel to use.
> 2.6 looks a lot like 2.5. New features are added very quickly without muc=
h=20
> testing. Of course there is Andrew's -mm tree but this one sometimes=20
> is too broken.
> For me linux looks now like it has one unstable tree (2.6) which is=20
> something like -ac was in days of 2.4 and  -mm was in the days of 2.4=20
> -2.5 and -mm which looks like it became very unstable.
> This is what i saw ok lkml (maybe my view is distorted).
> I'll stop ranting and try both of them because i have some bugs to report=
.

Man, -mm are unstable kernels, 2.6.x[.y] are the stable ones.

> The 2.6.x.y kernels sometimes are almost no different from 2.6.x

That's true, and good. the .y is the -stable tree, that is supposed to
add only stability and security fixes.

--=20
Marcos Marado <marado@isp.novis.pt>
Novis ISP

--=-ANSTIyqBw5h9mUp8dt18
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDchmArpje80Vhea8RAv3WAKChW1VFvm1WrS3yzLznOueYJ4oQLgCgpfny
O529dqS18K8TWLAD4fQp8OU=
=XOII
-----END PGP SIGNATURE-----

--=-ANSTIyqBw5h9mUp8dt18--

