Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSJAMsc>; Tue, 1 Oct 2002 08:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJAMsc>; Tue, 1 Oct 2002 08:48:32 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:22510 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261596AbSJAMsb>; Tue, 1 Oct 2002 08:48:31 -0400
Subject: Re: Adpter card read old memory value
From: Arjan van de Ven <arjanv@redhat.com>
To: Eitan Ben-Nun <eitan@sangate.com>
Cc: linux-kernel@vger.kernel.org, Uri Lublin <uri@sangate.com>
In-Reply-To: <B71796881E0DF7409F066FE6656BDF2906F78A@beasley>
References: <B71796881E0DF7409F066FE6656BDF2906F78A@beasley>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-UrWzuP2Im5WQoHZ1oj21"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Oct 2002 14:56:47 +0200
Message-Id: <1033477007.2672.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UrWzuP2Im5WQoHZ1oj21
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-01 at 14:43, Eitan Ben-Nun wrote:
> This seems like a cache coherency problem:=20
> An adapter card on the pci bus send a message to pc i386 Linux to update =
a memory address.=20
> Then it reads the address and sees an old value, even though the pc cpu h=
ave performed an update to this memory address.=20

uhm your report is missing a pointer to the source of the driver so
nobody can help you by looking at what's going on....


--=-UrWzuP2Im5WQoHZ1oj21
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9mZuPxULwo51rQBIRAmV9AJ0XmXUea2FvQTZ4OBH0bFki+h1ItQCdEPXw
gvQx178wdGYYOh8Zh1y2asI=
=i8tm
-----END PGP SIGNATURE-----

--=-UrWzuP2Im5WQoHZ1oj21--

