Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312190AbSCTVZC>; Wed, 20 Mar 2002 16:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312200AbSCTVYw>; Wed, 20 Mar 2002 16:24:52 -0500
Received: from ns01.passionet.de ([62.153.93.33]:8596 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S312190AbSCTVYm>; Wed, 20 Mar 2002 16:24:42 -0500
Date: Wed, 20 Mar 2002 22:24:28 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: steve.cameron@compaq.com, linux-kernel@vger.kernel.org
Subject: Re: Hooks for random device entropy generation missing in
 cpqarray.c
Message-ID: <197770.1016663068@eva.dhcp.gimlab.org>
In-Reply-To: <20020320150742.A4450@zuul.cca.cpqcorp.net>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========00215038=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========00215038==========
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

excuse me I am using 2.4.18

Manon

--On Mittwoch, 20. M=E4rz 2002 15:07 Uhr -0600 Stephen Cameron=20
<steve.cameron@compaq.com> wrote:

> On Wed, 20 Mar 2002, Manon Goo wrote:
>
>> All hooks for the random ganeration (add_blkdev_randomness() )
>> are ignored=3D20 in the cpqarray / ida  driver
>
> Try OR-ing in SA_SAMPLE_RANDOM in the call to request_irq().
>
> You don't say what kernel you're using, I think
> this is already in the latest 2.2, 2.4, 2.5 kernels,
> if I remember right... I see it in my copy of 2.2.21-pre3
> anyway.
>
> -- steve
>


--==========00215038==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mP4Tlp/TJR6NORURAjIkAJ9VT1QZ86et1X6sme54J8qnmFwlnQCbBu/F
a9hSFsmpQqY2rphmz+eCkf0=
=Gg1O
-----END PGP SIGNATURE-----

--==========00215038==========--

