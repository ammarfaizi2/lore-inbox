Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbRG2ELu>; Sun, 29 Jul 2001 00:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbRG2ELj>; Sun, 29 Jul 2001 00:11:39 -0400
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:16884 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267338AbRG2ELW>; Sun, 29 Jul 2001 00:11:22 -0400
From: Josh McKinney <forming@home.com>
Date: Sat, 28 Jul 2001 23:11:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.7 and VIA IDE
Message-ID: <20010728231123.A6128@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <E15QWqv-0007qf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <E15QWqv-0007qf-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On approximately Sat, Jul 28, 2001 at 05:22:09PM +0100, Alan Cox wrote:
> >         This is sort of a continuation of my last msg. I tried a rpm
> > -Va on one xterm and a tar cf /dev/null / on another, and I got
> > another dma error:
> >=20
> > hda: dma_intr: status=3D0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=3D0x84 { DriveStatusError BadCRC }
>=20
> BadCRC is normally a cable error, but I'm suspicious that its also one of
> the things caused by PCI bus problems on the VIA stuff
    I am running the same chipset and used to see these sort of problems in
the early 2.3pre and 2.4 days, but have not seen a BadCRC error for a long
time. =20

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Y4zqNkH04TEdiy8RAhSoAJ9e6FJp21zjY2Qohxq5O4Z2XznozwCeO+gH
Z9t2XZRwN/0C5Gi95kvIPUE=
=qU6R
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
