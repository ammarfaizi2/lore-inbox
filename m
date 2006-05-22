Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWEVPsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEVPsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVPsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:48:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:38590 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750733AbWEVPso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:48:44 -0400
X-Authenticated: #2308221
Date: Mon, 22 May 2006 17:48:30 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Knutar <jk-lkml@sci.fi>, Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060522154830.GA5344@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1148312458.17376.54.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2006 at 04:40:58PM +0100, Alan Cox wrote:
>=20
> Lead acid batteries should be kept well charged to avoid sulphation and
> always full charged when recharging, preferably using a charger that
> will do proper three step charging. "Cycling" a lead acid battery is a
> great way to destroy it.
>=20

So it is better to use only one battery (or an array thereof) which is
sort of charged and discharged at the same time, or is this idea just as
screwed..? I don't have a degree in electronics, mind you : )

Might be easier to build something that keeps a battery well maintained
and switches in case of power outage. With large enough condensors to
bridge the gap, which would also iron out any peaks and stuff, this
should work pretty well.

Kind regards,
Chris

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHHdTV2m8MprmeOlAQLv7hAAoruJSr9tjowz7/TcSHz5PNFwqLerzPrP
TW7+F7U3wdWSSxjt+ijNJUo2/MlSzxC7jBmzApY1U24z+U8q6zS5TVoU1ncBGjTP
dqsRz+qFGzt5e5AqmZMDmVwETnA1Gg9Ev+d5h2y5I8Fpc2WnWyZ3eiRNn9AAjENR
D2dD1HSq7X5fSAGfkypPqNzDihOeJfqJWmThGw6RKMl6lc8gA85tAd44Y8C09Gi+
BUZupdw2MRQuTn0gnEawE2dV1bCSL1aud9y68XAAjUmLVm3wy7veLGo0ylq28nxN
SlGwr5l7ksnRuBHqc7gU88fmsEQFzjDtolaDnalL8Uucxm3QkUnA4ls+je/rcFP9
CGbA1QYlCm1ZqFUK/809ila2zmjLKdcbBoOmNH8gYWshJMyHfFNDKAEEqTOGias+
hfBnRukDt4RjGj6YO8kxuebLqryWzz2xZG4OfPJe/qQSABYKwf4kOXf7DAbj35PR
fkHIY+zu7IpsLkjOSaDAlAjUgWBeEWstZlKmPa9QOLdjmchdphSXXQzGmM6s1AkQ
QSbWO10mPg8idb/klNvz0//rNO5j+BNlzIXGN3XNvVO0SP/oI3RxdTwmmGx1D9oa
LBaRgfTwodwz8aT5WPKlgr+pCG5544KyRa3QOnAuchG2vwbQb70PSx0WwApWn+8+
T8dGuz98nzQ=
=FZ5l
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

