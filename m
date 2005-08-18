Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVHRUxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVHRUxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHRUxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:53:15 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:45426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932419AbVHRUxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:53:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:reply-to:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to;
        b=qju0/ufvmyxQNxedi8LTh0VGgcYd3QjIJKOQC4PUBBkasUZ2XyUvHJe+BsTe52Hqj+qV5+P1rW2g86AVUvqBTV419LBYDjL/1KPPh6oSSV1/H2/EonWi0AMaZGlkBJgv+Hdeh6njOa5rpcXvtuvTNZuwu6i0PILPXaBHSV+XHhI=
Date: Thu, 18 Aug 2005 22:58:21 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atheros and rt2x00 driver
Message-ID: <20050818205821.GA30510@localhost.localdomain>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <6278d22205081711115b404a9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <6278d22205081711115b404a9b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Daniel J Blueman <daniel.blueman@gmail.com> wrote:
->=20
-> There is a good chance the rt2x00 driver will get into the kernel tree
-> in time, since there is no firmware to upload - Ralink Tech
-> (www.ralink.com.tw) took a design decision to incorporate the firmware
-> into an EEPROM on-board, allowing their driver to be GPL'd, and the
-> rt2x00 is a Linux-specific rewrite which is stabilising well.
=20
  the same applies to atheros. they got stuff either in eeprom or in
  driver. no firmware necessary.=20
 =20
  there is an ongoing project for atheros cards.
  work in progress located at http://mateusz.agrest.org/atheros/


  /M

--=20
  @..@   Mateusz Berezecki=20
 (----)  mateuszb@gmail.com http://mateusz.agrest.org
( >__< ) PGP: 5F1C 86DF 89DB BFE9 899E 8CBE EB60 B7A7 43F9 5808=20
^^ ~~ ^^

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBPZtKu1H8AtEdBoRAixJAJ9wazxR9CUPiLzJLIRiDWGHDQxKZwCaAnsE
LLT8zLNQR0AbdAGX1itRHrY=
=C/Fz
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

