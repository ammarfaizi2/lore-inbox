Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422736AbWATCRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWATCRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWATCRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:17:39 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:9093 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1422736AbWATCRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:17:37 -0500
Date: Fri, 20 Jan 2006 13:17:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: dwmw2@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
Message-Id: <20060120131704.51995386.sfr@canb.auug.org.au>
In-Reply-To: <20060118.223629.100108404.davem@davemloft.net>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
	<20060119171708.7f856b42.sfr@canb.auug.org.au>
	<20060118.223629.100108404.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__20_Jan_2006_13_17_04_+1100_OmVUNvBAGR=Ptl=0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__20_Jan_2006_13_17_04_+1100_OmVUNvBAGR=Ptl=0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jan 2006 22:36:29 -0800 (PST) "David S. Miller" <davem@davemloft=
.net> wrote:
>
> Hmmm, what args does function X take?  Let's try this:
>=20
> bash$ git grep X
>=20
> Oops, the args went past 80 columns and was split up, so I only
> get the first few in the grep output.

git grep -A2 X

:-)  (now I am just being silly :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_Jan_2006_13_17_04_+1100_OmVUNvBAGR=Ptl=0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0EgmFdBgD/zoJvwRAo9eAJ9TFdB+5YILXUVoUmhlS8GGGJlfdACdEtgk
EizrHft132s91m+fCG5A+xU=
=YUJk
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Jan_2006_13_17_04_+1100_OmVUNvBAGR=Ptl=0--
