Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUB1Not (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 08:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbUB1Not
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 08:44:49 -0500
Received: from ip-a1-37024.keycomm.it ([62.152.37.24]:31841 "EHLO
	sparc.campana.vi.it") by vger.kernel.org with ESMTP id S261845AbUB1Nor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 08:44:47 -0500
Date: Sat, 28 Feb 2004 14:43:32 +0100
From: Ottavio Campana <ottavio@campana.vi.it>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25, problem with broadcomm nics
Message-ID: <20040228134332.GA3612@campana.vi.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
X-Operating-System: Linux dirac 2.4.25-dirac 
X-Organization: Lega per la soppressione del Visual Basic
X-Homepage: http://www.campana.vi.it/ottavio/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm just installing debian woody on a new server DL140.

I'm trying to  get 2.4.25 working on  it, but I'm having  a problem with
its two broadcomm  cards. When it boots  I cannot see the  devices, if I
give lspci I just  get the cards starting with 00:* but  I don't see the
two networking cards that have got an address starting with 02:* .

I thought  it was an apic  problem, I tried  to boot with noapic  an the
server was  unusable: the cards don't  come up and the  keyboard doesn't
work.

Does anyone of you have got an idea?

PS: can you please cc me, for I didn't subscribe the list, please?

--=20
Non c'=E8 pi=F9 forza nella normalit=E0, c'=E8 solo monotonia.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQJsE7rbS9ADlfXwRAgecAJ0V7qntjxqz1duRjMqJxxRo8eS3OgCgrXGH
6jtxxayjqKK5pdYZXO8NlEg=
=Rhlc
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
