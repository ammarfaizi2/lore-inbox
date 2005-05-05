Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVEEPLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVEEPLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVEEPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:11:54 -0400
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:62887 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262131AbVEEPLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:11:48 -0400
Subject: Re: Re[2]: ata over ethernet question
From: David Hollis <dhollis@davehollis.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1104082357.20050504231722@dns.toxicfilms.tv>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rFfXKbTPwLBG55iw68e1"
Date: Thu, 05 May 2005 11:09:54 -0400
Message-Id: <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rFfXKbTPwLBG55iw68e1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-04 at 23:17 +0200, Maciej Soltysiak wrote:
> Hello David,
>=20
> Wednesday, May 4, 2005, 9:48:36 PM, you wrote:
> > That seems to be the basic idea but there doesn't seem to be a provider
> > stack just yet, just a 'client' (though I could be wrong).  AOE is
> > similar in concept to iSCSI with the biggest difference being that AOE
> > runs over Ethernet and is thus non-routeable.  iSCSI operates over IP s=
o
> > you can do all kinds of fun IP games with it.
> Thanks, this is interesting. Does the iSCSI implementation out there have
> this provider stack ?
>=20
> Regards,
> Maciej

There seem to be a few iSCSI implementations floating around for Linux,
hopefully one will be added to mainline soon.  Most of those
implementations are for the client side though there is at least one
target implementation that allows you to provide local storage to iSCSI
clients.  I don't remember the name of it or if it's still maintained or
not.

--=20
David Hollis <dhollis@davehollis.com>

--=-rFfXKbTPwLBG55iw68e1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCejdBxasLqOyGHncRAvU1AJ0bRInq0YDA/1cagSseZRo4CTmudwCfaqO3
VSn/zpPmm702qgSC43A925Q=
=1SU1
-----END PGP SIGNATURE-----

--=-rFfXKbTPwLBG55iw68e1--

