Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTGQP5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTGQP5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:57:34 -0400
Received: from 64-76-6-141-tnttlp2.dial-up.net.ar ([64.76.6.141]:4224 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S271108AbTGQP5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:57:32 -0400
From: Norberto BENSA <nbensa@gmx.net>
Reply-To: nbensa@yahoo.com
Organization: BENSA.ar
To: Terje Kvernes <terjekv@math.uio.no>
Subject: Re: 2.6 sound drivers?
Date: Thu, 17 Jul 2003 13:08:51 -0300
User-Agent: KMail/1.5.2
Cc: Jeff Garzik <jgarzik@pobox.com>, Max Valdez <maxvalde@fis.unam.mx>,
       kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net> <200307162318.27081.nbensa@gmx.net> <wxx7k6h8f5n.fsf@nommo.uio.no>
In-Reply-To: <wxx7k6h8f5n.fsf@nommo.uio.no>
X-Operating-System: Gentoo GNU/Linux 1.4
X-PGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_WosF/Iu7XcEYMPy";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307171308.54518.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_WosF/Iu7XcEYMPy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Terje Kvernes wrote:
> Norberto BENSA <nbensa@gmx.net> writes:
> > Last time I've checked ALSA, it didn't support bass and treble,
> > that's why I'm using OSS (emu10k1)
>
>   I have treble and base support on my emu10k1 via ALSA.

How could this be true if:

Ian Hastie wrote:
> ALSA's support seems usable, but still doesn't allow you to programme the
> DSP with your own code.  OSS uses this to enable such things as bass and
> treble controls, as well as a selection of audio effects with code
> provided.  Anyone know if ALSA will allow this kind of thing in the futur=
e?

???

Anyone (Terje, Ed) care to say HOW did you enabled treble and bass in emu10=
k1=20
(ALSA) or you will continuously say "it works for me" without saying anythi=
ng=20
useful?

Many thanks in advance,
Norberto
=2D-=20
$ man women
No manual entry for women


--Boundary-02=_WosF/Iu7XcEYMPy
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/FsoWFXVF50lmS74RAoX5AJ9kIrmmaXmyGJw6iVkxU1zzLQGYDACfc4JI
361fKFozuba9Q1lL46eSLG0=
=4Mty
-----END PGP SIGNATURE-----

--Boundary-02=_WosF/Iu7XcEYMPy--

