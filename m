Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbSJTKBx>; Sun, 20 Oct 2002 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265799AbSJTKBw>; Sun, 20 Oct 2002 06:01:52 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:18926 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265798AbSJTKBv>; Sun, 20 Oct 2002 06:01:51 -0400
Subject: [LARGE patch 23/124] sets sent over and over again Re: [PATCH]
	ext2/3 updates for 2.5.44 (1/11): Default mount options in superblock
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E183CUa-0007Yq-00@snap.thunk.org>
References: <E183CUa-0007Yq-00@snap.thunk.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-qJcFxju/gOyP6L/biJ1y"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Oct 2002 12:09:35 +0200
Message-Id: <1035108575.3130.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qJcFxju/gOyP6L/biJ1y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I know everybody wants to be cool and split their patchkit up. I'm all
for that. But why oh why do these sets have to be sent to LKML every
time when a new upstream kernel is released and the only change is a
rsync? (and Ted, this is not meant as a personal assault of any kind,
your mail was just the one that was the final drop in the bucket)

I hereby politely ask EVERYONE who wants to (re)posts large patchsets,
to at minimum try to follow something like the following politeness
guidelines

1) Make it ONE thread. Do this by cc or bcc'ing yourself on the mails
   and use the reply feature of your mailer to reply each next number of
   the set to the previous one. This allows people that use mail/news
   readers that can do threading to properly sort it. This is not hard,
   and I consider it the least you can do for the people that read lklm.

2) Do not resent all 506 parts of your patchkit every time Linus
   releases a new kernel and all you did was merge up. Post 1 mail with
   the fact that you did this and an URL to the patchkit if you feel
   everyone and their dog really wants to know this fact. This does not
   mean that if you did significant cleanup work you shouldn't repost
   (while keeping #1 in mind), that obviously is of more interest.
  =20


On Sun, 2002-10-20 at 11:35, tytso@mit.edu wrote:
>=20
> This is the latest set of ext2/3 update patches, against 2.5.44.  The
> patches include:


--=-qJcFxju/gOyP6L/biJ1y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9soDfxULwo51rQBIRAnL+AJ9Ugj/ipF4gqjTnDRJVPepaeXPFDACdGt3I
zWuUZs2VjsF+YSesZ7mnP/s=
=Brr5
-----END PGP SIGNATURE-----

--=-qJcFxju/gOyP6L/biJ1y--

