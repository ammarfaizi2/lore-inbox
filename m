Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161498AbWATE1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161498AbWATE1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWATE1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:27:48 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:49331 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1161498AbWATE1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:27:35 -0500
Date: Fri, 20 Jan 2006 15:27:04 +1100
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: io performance...
Message-ID: <20060120042704.GB12447@samad.com.au>
Mail-Followup-To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it> <5wdKh-5wF-15@gated-at.bofh.it> <43CEF263.9060102@shaw.ca> <43CF90C6.8050505@fastmail.co.uk> <1137679698.8471.30.camel@localhost.localdomain> <43D0626A.2090802@fastmail.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <43D0626A.2090802@fastmail.co.uk>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2006 at 12:09:14PM +0800, Max Waterman wrote:
> Alan Cox wrote:
> >On Iau, 2006-01-19 at 21:14 +0800, Max Waterman wrote:
> >>So, if I have my raid controller set to use write-back, it *is* caching=
=20
> >>the writes, and so this *is* a bad thing, right?
> >
> >Depends on your raid controller. If it is battery backed it may well all
> >be fine.
>=20
> Eh? Why?
>=20
> I'm not sure what difference it makes if the controller is battery=20
> backed or not; if the drives are gone, then the card has nothing to=20
> write to...will it make the writes when the power comes back on?
some do
>=20
> Max.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD0GaYkZz88chpJ2MRAsvqAJ9KcEpAmGftfyyaMYYuEJTRkkb2TACfXCi4
+zR4va4GXLwsf1j9xKh13+M=
=1/pL
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
