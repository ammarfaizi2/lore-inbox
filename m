Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWCFQCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWCFQCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWCFQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:02:41 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:34496 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750709AbWCFQCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:02:40 -0500
Date: Mon, 6 Mar 2006 17:02:34 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to -mm tree
Message-ID: <20060306160234.GF19703@wavehammer.waldi.eu.org>
Mail-Followup-To: Cornelia Huck <cornelia.huck@de.ibm.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net> <20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com> <20060306135017.GA18874@wavehammer.waldi.eu.org> <20060306163950.5eb027e6@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20060306163950.5eb027e6@gondolin.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2006 at 04:39:50PM +0100, Cornelia Huck wrote:
> You're right. I don't like the tmp_length too much, but can't think of
> anything better.

This will get fixed in my next patch, which uses add_uevent_var where
possible.

Bastian

--=20
A woman should have compassion.
		-- Kirk, "Catspaw", stardate 3018.2

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkQMXRoACgkQnw66O/MvCNHuQgCdGqRnkT7bcEv/bpmAWljHi/XK
BzgAoJFwFEF9FCxlFew5Fke8DERyuORk
=rPm9
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
