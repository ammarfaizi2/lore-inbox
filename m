Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbRCZS3d>; Mon, 26 Mar 2001 13:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbRCZS3X>; Mon, 26 Mar 2001 13:29:23 -0500
Received: from client38038.atl.mediaone.net ([24.88.38.38]:62711 "HELO
	whitestar.soark.net") by vger.kernel.org with SMTP
	id <S132530AbRCZS3T>; Mon, 26 Mar 2001 13:29:19 -0500
Date: Mon, 26 Mar 2001 13:28:33 -0500
From: "Zephaniah E\. Hull" <warp@whitestar.soark.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Lovely crash with 2.4.2-ac24.
Message-ID: <20010326132833.B3920@whitestar.soark.net>
In-Reply-To: <20010326121747.A3920@whitestar.soark.net> <Pine.LNX.4.10.10103260944170.12547-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10103260944170.12547-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Mar 26, 2001 at 09:46:54AM -0800
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2001 at 09:46:54AM -0800, Andre Hedrick wrote:
>=20
> Zephaniah,
>=20
> Does this happen in a non-ac kernel?
> I have not updated code since around 2.4.0, but other have.
> You point ot a few times w/ ac18, but is there one before that which does
> not cause this to happen?
>=20
> The question is to gain isolation of the changes.

I'm not sure, I did not see it on 2.4.2-ac18 until I started doing a lot
of X compiling, but I can't reproduce at will which makes this a little
harder.

I could try 2.4.2 the current 2.4.3-pre kernels from Linus if that would
help? (Though, as I said, it seems to happen semi-randomly, though more
when there is heavy disk activity.)

Zephaniah E. Hull.
>=20
> On Mon, 26 Mar 2001, Zephaniah E. Hull wrote:
>=20
> > This had hit me a few times with ac18 (I'm not sure it was the same
> > crash though) and just hit me again with ac24.
> >=20
> > Alan cced due to it being in the ac kernels, Andre because the trace
> > seems to point to the IDE code.
> >=20
> > Thanks.
> >=20
> > Zephaniah E. Hull.
> >=20
> > --=20
> >  PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
> >     Keys available at http://whitestar.soark.net/~warp/public_keys.
> >            CCs of replies from mailing lists are encouraged.
> >=20
> > <cas> Mercury: gpm isn't a very good web browser.  fix it.
> >=20
>=20
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -------------------------------------------------------------------------=
----
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
>=20

--=20
 PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
    Keys available at http://whitestar.soark.net/~warp/public_keys.
           CCs of replies from mailing lists are encouraged.

"Delivery anywhere in the world within thirty minutes or the second one's
 free." - "pizza box" art atop a Minuteman ICBM silo, Paul A. Suhler, RHF

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6v4pRRFMAi+ZaeAERAlRLAKD2Lob7KjkICxRfqNMHzXtyVDH1zACgtIGH
oiRCRt/qyeyXEniwHXa8iDc=
=9X/w
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
