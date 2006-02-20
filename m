Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWBTW2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWBTW2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWBTW2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:28:14 -0500
Received: from ctb-mesg4.saix.net ([196.25.240.74]:64460 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S932625AbWBTW2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:28:13 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200602201354.00595.dhazelton@enter.net>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	 <43F7257D.80400@tmr.com> <43F9E8C2.nail4ALB11DH3@burner>
	 <200602201354.00595.dhazelton@enter.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q9HKO3NoAOa0WJnKWjGV"
Date: Tue, 21 Feb 2006 00:30:49 +0200
Message-Id: <1140474649.29789.32.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q9HKO3NoAOa0WJnKWjGV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-20 at 13:53 -0500, D. Hazelton wrote:
> On Monday 20 February 2006 11:05, Joerg Schilling wrote:
> > Bill Davidsen <davidsen@tmr.com> wrote:
> > > >If you did ever try to write reliable code that has to deal with thi=
s
> > > > kind of oddities, you would understand that it is sometimes better =
to
> > > > wait and to inform related people about the problems they caused.
> > >
> > > This ground has been covered. And at least in the case of filtering
> > > commands, that had to be done quickly and you know it.
> >
> > We all know that filtering is not needeed to fix a bug. It could have b=
een
> > implemented completely relaxed and without any time pressure as the bug
> > that needed fixing could have been fixed by just requiring a R/W FD to
> > allow SG_IO.
>=20

Pretty sure it was not to fix a bug, but to plug a possible security
issue with non-root users being able to do whatever they wanted on a R/W
FD.

> In one post you complain that SG_IO is unneeded on /dev/hd* and related=20
> devices and in this one you say that it's all that would have been needed=
 to=20
> fix a bug!
>=20
> Joerg, I think it's time you stop dodging questions, shifting blame and a=
ll=20
> the tactics you've been using and admit that you just don't like Linux. A=
fter=20
> all, every time you are asked to provide a technical basis for an argumen=
t=20
> you have three main tactics - Dodge it entirely, misquote POSIX or say "B=
ut=20
> Solaris does it this way".
>=20
> As you well know I've asked you for quality information I could use to tr=
y and=20
> fix the bug in the kernel where it munges the CDB for certain drives and =
am=20
> trying to work with you to develop a patch that will let libscg scan both=
 the=20
> SCSI and ATA/ATAPI bus on Linux. I realize I'm an unknown factor here, si=
nce=20
> I've never found any place where my skills would come in useful on a majo=
r=20
> project like cdrecord or Linux, but now I have.
>=20
> If you do not want the help just say such. If you just want to complain a=
bout=20
> problems and preach about how great Solaris is, then you are nothing but =
a=20
> feigen schweinhund and deserve to receive no more of my time.
>=20
> (and yes, my German is probably quite bad. It's been a very long time sin=
ce=20
> I've used any of it on a regular basis)
>=20

No need to waste your time .. he did not want it to work properly on
Linux for years now, and the only reason Linux support have not been
removed yet, is because then it will break his 'O so wonderful and only
proper "schily" way for "protability to more plaforms than you get from
using an GNU autoconf the way the GNU people tell you"'.  Oh, and then
he looses his favourite "plaform" to rant about.

PS: quoted spelling mistakes are not a pun, its just to make sure I do
not get accused of being a liar ...


Still Amused,

--=20
Martin Schlemmer


--=-q9HKO3NoAOa0WJnKWjGV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD+kMZqburzKaJYLYRAr+lAJ91xQlKUlRE/XzbujgIrVg6NOtKpwCcCn1s
chHSZfzkSU0dpI4FFCgpH2M=
=+g2z
-----END PGP SIGNATURE-----

--=-q9HKO3NoAOa0WJnKWjGV--

