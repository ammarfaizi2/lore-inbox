Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVAQXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVAQXdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVAQX3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:29:18 -0500
Received: from hostmaster.org ([212.186.110.32]:14817 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S262789AbVAQX0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:26:17 -0500
Subject: Re: usb-storage on SMP?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1105983790.16119.5.camel@localhost.localdomain>
References: <1105982247.21895.26.camel@hostmaster.org>
	 <200501171826.33496.rjw@sisk.pl>
	 <1105983790.16119.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5mG2FVPJ6MTfB/dqet1p"
Date: Tue, 18 Jan 2005 00:26:14 +0100
Message-Id: <1106004374.21895.39.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5mG2FVPJ6MTfB/dqet1p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I forgot to mention that I am using a 2.6.10 kernel but will try
2.6.11rc1 soon. Are you using a SMP system? I assume the cabling, card
reader and SD card are OK because the problem went away with maxcpus=3D1,
the problem must be in the USB ehci/ohci/storage drivers. Do you know if
there is any difference between addressing external hard disks and SD
cards?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Microsoft Windows(tm). A thirty-two bit extension and graphical shell
to a sixteen bit patch to an eight bit operating system originally
coded for a four bit microprocessor which was written by a two-bit
company that can't stand one bit of competition.




--=-5mG2FVPJ6MTfB/dqet1p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQexJlmD1OYqW/8uJAQKmmQf/TT6oOed0gHntY0khnTUFvXd1qU07Bmcu
UNFFhxR/5cXP32Bx1ypS0SjCcYiRjHW7d1tuo3xEQfxd8QUokrwd96YWBvqjkbcm
JO8ZwkBTx6MnB52jdBDupFISsI10bCf5q2nYt7vDPughEkDRPzHl9JL0ufLMSTNM
7QzkFBAcEQhUvIuKcc/5VikPEDk9r3aAcYuAcwyf+en5cjUDlzTPyOAN9jscAd6j
uxflgRikBdDxzw0S7vKcsD+VQkMV3+z5yzR1pfj2NObKl8vSjOPZttraLjBfO2K/
ty6+j7U7X/m+MMQKy5Tb9lZZFFB4BXrJ/L85arv3ShSle5QMxytQOw==
=WPuJ
-----END PGP SIGNATURE-----

--=-5mG2FVPJ6MTfB/dqet1p--

