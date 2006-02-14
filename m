Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWBNFJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWBNFJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWBNFJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:09:42 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:13264 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1030416AbWBNFJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:09:38 -0500
Date: Tue, 14 Feb 2006 16:09:36 +1100
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214050936.GM26235@samad.com.au>
References: <20060208162828.GA17534@voodoo> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner> <200602092221.56942.dhazelton@enter.net> <43F08C5F.nailKUSDKZUAZ@burner> <mj+md-20060213.140141.31817.atrey@ucw.cz> <43F0A5E1.nailKUS106KMUQ@burner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <43F0A5E1.nailKUS106KMUQ@burner>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2006 at 04:29:37PM +0100, Joerg Schilling wrote:
> Martin Mares <mj@ucw.cz> wrote:
>=20
> > Hello!
> >
> > > libscg abstracts from a kernel specific transport and allows to write=
 OS=20
> > > independent applications that rely in generic SCSI transport.
> > >=20
> > > For this reason, it is bejond the scope of the Linux kernel team to d=
ecide on=20
> > > this abstraction layer. The Linux kernel team just need to take the c=
urrent
> > > libscg interface as given as _this_  _is_ the way to do best abstract=
ion.
> >
> > Do you really believe that libscg is the only way in the world how to
> > access SCSI devices?
> >
> > How can you be so sure that the abstraction you have chosen is the only
> > possible one?
> >
> > If an answer to either of this questions is NO, why do you insist on
> > everybody bending their rules to suit your model?
>=20
> Name me any other lib that is as OS independent and as clean/stable as
> libscg is. Note that the interface from libscg did not really change=20
> since August 1986.=20

off the top of my head the standard C library been fairly stable

>=20
>=20
> > > The Linux kernel team has the freedom to boycott portable user space =
SCSI=20
> > > applications or to support them.
> >
> > That's really an interesting view ... if anybody is boycotting anybody,
> > then it's clearly you, because you refuse to extend libscg to support
> > the Linux model, although it's clearly possible.
>=20
> Looks like you did not follow the discussion :-(
>=20
> I am constantly working on better support for Linux while the Linux kernel
> folks do not even fix obvious bugs.
>=20
> J?rg
>=20
> --=20
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) J?rg Schilling D-13353 Be=
rlin
>        js@cs.tu-berlin.de                (uni) =20
>        schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogs=
pot.com/
>  URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/s=
chily
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8WYQkZz88chpJ2MRAqvIAKDuJA4i6XPU3jX9dXkxN5lCWl9yAwCgy/5n
p95H1LH+hF4/Y8ZtKm+2CtQ=
=5fpy
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--
