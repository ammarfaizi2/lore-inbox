Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVBYTPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVBYTPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVBYTPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:15:54 -0500
Received: from hostmaster.org ([212.186.110.32]:60328 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S262778AbVBYTPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:15:46 -0500
Subject: Re: usb-storage on SMP?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1105982247.21895.26.camel@hostmaster.org>
References: <1105982247.21895.26.camel@hostmaster.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b1XxpkEHUnW8+E+hdYLk"
Date: Fri, 25 Feb 2005 20:15:43 +0100
Message-Id: <1109358944.8562.6.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b1XxpkEHUnW8+E+hdYLk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

It seems now that the problem was caused by my 6in1 Card Reader that
identifies itself as "ID 0dda:0001 Integrated Circuit Solution, Inc.".

Strange thing is that the problem went away with maxcpus=3D1 for my 256MB
SD-Cards but not with my new 1GB SD-Card now.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Microsoft Windows(tm). A thirty-two bit extension and graphical shell
to a sixteen bit patch to an eight bit operating system originally
coded for a four bit microprocessor which was written by a two-bit
company that can't stand one bit of competition.




--=-b1XxpkEHUnW8+E+hdYLk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQh95X2D1OYqW/8uJAQLfIAf/auO8Y1LHToTiNHcS8LAKPQgLKqM3/pjG
QRr0PkoAL4q3XjDToiYt0iGuNdM75VSWIBfYTAm85BFN/+SMcP8yeFkSw68Z/p/P
B3NvizXtVLNtJmNVz8GeNg8vIxGPYd8iMm/UkQ3KMw/VGNCTjkDGWNqP9r7QGefO
ZKNrtdjLtajg380pSCGYGmYu0oETs3MLPmMbc/Cg+EmwVPzF3IAilPjEwEnp3yzK
OeCcYOJz22uFmYOqemO50eIRyglhm0bLGH9dgl+UoMOrso/Zf3h3IA/014lwGflu
eF8ltXCbiuaqBZfF254uzJuGYgLHLCecuMgryuRLiFCaqCrIlVOTHQ==
=6Emj
-----END PGP SIGNATURE-----

--=-b1XxpkEHUnW8+E+hdYLk--

