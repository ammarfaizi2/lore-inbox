Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUDTPhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUDTPhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 11:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTPhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 11:37:46 -0400
Received: from legolas.restena.lu ([158.64.1.34]:45726 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263148AbUDTPhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 11:37:00 -0400
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: rol@as2917.net
Cc: "'Erik Steffl'" <steffl@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200404201522.i3KFMk120352@tag.witbe.net>
References: <200404201522.i3KFMk120352@tag.witbe.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NNJ0mEq9vR3uajOZdiU7"
Message-Id: <1082475417.6543.3.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Apr 2004 17:36:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NNJ0mEq9vR3uajOZdiU7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've got 4 PCs all with logitech cordless optical mice.. all work
perfectly with Gentoo dev sources 2.6.5.. as well as 2.6.3, 2.6.1 etc

Craig

On Tue, 2004-04-20 at 17:22, Paul Rolland wrote:
> Hello,
>=20
> >    it looks that after update to 2.6.5 kernel (debian source=20
> > package but=20
> > I guess it would be the same with stock 2.6.5) the mouse=20
> > wheel and side=20
> > button on Logitech Cordless MouseMan Wheel mouse do not work.
> I've got a new mouse with a wheel, and I've got the same problem,
> though I can't tell if it was working before...
>=20
> > Here's the most basic/simple situation/symptoms:
> >=20
> >    I stop X, read bytes from /dev/psaux (c program, using open and=20
> > read). for each mouse action there are few bytes read, usually number=20
> Could you provide me with the program so that I can test too ?
>=20
> >    BTW X windows is confused in the same way (I guess because that's=20
> > what it gets from kernel driver - using xev I found that it=20
> > thinks the=20
> > sidebutton is button 2 and that turning the wheel is not an=20
> > event at all).
> Got the same : wheel is no-op :-(
>=20
> I guess I should try a stock 2.4.x kernel to see if it working or
> not...
>=20
> Regards,
> Paul
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=-NNJ0mEq9vR3uajOZdiU7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAhUOZi+pIEYrr7mQRAp6nAJ9N7Ucq+lrT3yyTtVdVBpk7hyAwHgCfYlpH
PzNdC1Q8r7FXmrOz/R8CXiE=
=ceyM
-----END PGP SIGNATURE-----

--=-NNJ0mEq9vR3uajOZdiU7--

