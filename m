Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUH0WHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUH0WHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUH0WEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:04:06 -0400
Received: from dialin-212-144-169-004.arcor-ip.net ([212.144.169.4]:41414 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262329AbUH0WAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:00:20 -0400
In-Reply-To: <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org> <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org> <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales> <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org> <20040827185541.GC24018@isi.edu> <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-33--627354343"
Message-Id: <5A81E516-F874-11D8-88E5-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: non-i386 architectures (Re: Termination of the Philips Webcam Driver (pwc))
Date: Fri, 27 Aug 2004 23:59:22 +0200
To: Linus Torvalds <torvalds@osdl.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-33--627354343
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 27.08.2004, at 21:06, Linus Torvalds wrote:

> Whenever somebody says "accept the driver to help users", they are 
> missing
> the big picture. A binary driver SCREWS OVER users on other 
> architectures.
> It pretty much guarantees that those other architectures will never be
> supported

Suddenly my hopes seem to have paid off after the rumor that you'd 
switch
to ppc64. Indeed the nicest hardware in the world is one of those pieces
which have the most troubles running Linux in its full shininess just
because some of the components are "supported on Linux" only in form of
some binary non-SMP x86 crap or not supported at all. While the latter 
is
not a problem at all[1] the former will always bite people sometimes 
even
*if* they are running the correct architecture. The only way to show
protest is to not buy those products at all and let the manufacturer 
know
in clear terms why they've just missed another $50-$50000 deal[2], if
enough people are doing this, there's a slight chance that the company
will reconsider their screw-up. If people continue using what's there
because it "is better than nothing" then all others will be even more
treated as idiots because "the drivers obviously work".

[1] Assuming the hardware in question is not a notebook and the 
component
     vital.
[2] Depending very much on the price of the product and the quantity.

Servus,
       Daniel

--Apple-Mail-33--627354343
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQS+uujBkNMiD99JrAQIztgf/d39YUHhdThH1hLv87s0m3nI7qz5zK7cq
pykjbtZHZW1jHp0n0eeHICSAx3wbm9QRZ++uU5+dw/Jb+NhMR1XHVoEBLjD0T3bK
RpGUZXs+kz82y6jfOUXJ8BxtayCFelg88NHDNMeF31mnN6yLjf0adXoLFlyCmVbP
ThjpbihOcsLWdlWXBGXonWEnMkeEIW0SgpLmAkS7b+b6Bc2yGbjJpxYx1SES7Og1
AaJDHsiR7u5NEw584XbjggNnzGPzFhtpNGrMzzai0wjATKuovOl1sonput6Z5n4d
BI5S+BNu+M1MfH47Ib8JY6zwwa0UEcT9UmWkec/c7r028TKsERjY5Q==
=Tw+7
-----END PGP SIGNATURE-----

--Apple-Mail-33--627354343--

