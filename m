Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbRAWMRl>; Tue, 23 Jan 2001 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbRAWMRb>; Tue, 23 Jan 2001 07:17:31 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:3277 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S130304AbRAWMRN>; Tue, 23 Jan 2001 07:17:13 -0500
Date: Tue, 23 Jan 2001 12:16:11 +0000
From: Anders Karlsson <anders.karlsson@meansolutions.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac10 compile errors
Message-ID: <20010123121611.A3723@alien.ssd.hursley.ibm.com>
In-Reply-To: <20010123104814.A2937@alien.ssd.hursley.ibm.com> <23801.980250214@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23801.980250214@ocs3.ocs-net>; from kaos@ocs.com.au on Tue, Jan 23, 2001 at 10:43:34PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2001 at 10:43:34PM +1100, Keith Owens wrote:
> On Tue, 23 Jan 2001 10:48:14 +0000,=20
> Anders Karlsson <anders.karlsson@meansolutions.com> wrote:
> >The procedure I have gone through to compile the kernel are as
> >follows:
> >a) Copy the .config file safe
> >b) Remove the previous kernel tree
> >c) Extract the pristine 2.4.0 kernel tree
> >d) Apply the 2.4.0-ac10 patch
>=20
> make mrproper here

Even if it is a pristine kernel tree? What function does the 'make
mrproper' fill on an unused kernel tree?

--=20
        Anders Karlsson                     Mean Solutions Ltd.
e-mail: anders.karlsson@meansolutions.com   Mobile: +44-7711-876270

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjptdgoACgkQhWP0bzSeaGPXpwCg3pexs991UiBsk/54PaLPrSZt
nWMAnix1sMR2vZl6jyCcW9LoE/fZt6nc
=MQb2
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
