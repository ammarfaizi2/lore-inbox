Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSEGMc0>; Tue, 7 May 2002 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315429AbSEGMcZ>; Tue, 7 May 2002 08:32:25 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:3086 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315427AbSEGMcY>;
	Tue, 7 May 2002 08:32:24 -0400
Date: Tue, 7 May 2002 16:36:47 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 55
Message-ID: <20020507123647.GA283@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205071345110.32715-100000@serv> <3CD7B826.7000000@evision-ventures.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=92=D1=82=D1=80, =D0=9C=D0=B0=D0=B9 07, 2002 at 01:19:02 +0200, Marti=
n Dalecki wrote:
> Uz.ytkownik Roman Zippel napisa?:
> >Hi,
> >
> >On Tue, 7 May 2002, Martin Dalecki wrote:
> >
> >
> >>>>Then ide-pci.c is still compiled into the kernel. Why?
> >>>
> >>>Becouse the big tables there are subject to go.
> >>
> >>And at some point in time it will check whatever there is
> >>request for any host chip support.
> >
> >
> >Could you please then do the above change _after_ you have done this?
>=20
> Well one question renames: Please name me one PCI based architecture
> which contains IDE support and does not contain any special host chip
> attached to the very same PCI bus as well.

SiS 496/497 PCI chipset for i486's. It has integrated IDE controller,
but this controller is not connected to PCI bus.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE818pfBm4rlNOo3YgRAlB8AJ9HQ+D/Ioyl2adlYjLJp8c+3o/CXQCfUiX7
08N4goA03SINHz0TTPJ/J0Y=
=uBrC
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
