Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290881AbSBUJoZ>; Thu, 21 Feb 2002 04:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290926AbSBUJoQ>; Thu, 21 Feb 2002 04:44:16 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:46860 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S290881AbSBUJoH>;
	Thu, 21 Feb 2002 04:44:07 -0500
Date: Thu, 21 Feb 2002 12:48:07 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Idiot-proof APIC?
Message-ID: <20020221094807.GA275@pazke.ipt>
Mail-Followup-To: Allan Sandfeld <linux@sneulv.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16dc5j-0000CB-00@Princess>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <E16dc5j-0000CB-00@Princess>
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A1=D1=80=D0=B4, =D0=A4=D0=B5=D0=B2 20, 2002 at 08:07:47 +0100, Allan=
 Sandfeld wrote:
> I recently had the misfortune to try to put two celerons on an SMP-board.=
 The=20

If you have Celerons based on Mendocino core you can easily hack
them to work in SMP even with Socket370 motherboard.
Celerons based on Copermine core are not SMP capable and can cause=20
any brain-damaged behavior.=20

And Linux can't work aroud all crazy combinations of SMP incapable CPUs :))

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8dMJXBm4rlNOo3YgRAoOgAKCDUuu8fSBVAHmO7skCh7ylw6Bo2QCfb9dc
5sFkPEiIr6rT3w5qFU4qo6E=
=zLmp
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
