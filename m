Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755471AbWKOC67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbWKOC67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbWKOC67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:58:59 -0500
Received: from ozlabs.org ([203.10.76.45]:3511 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1755471AbWKOC66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:58:58 -0500
Subject: Re: [RFC] [PATCH] cpu_hotplug on IBM JS20 system
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, anton@au1.ibm.com,
       paulus@samba.org, linuxppc-dev@ozlabs.org, ego@in.ibm.com,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4559C6A9.4070204@in.ibm.com>
References: <45586EB5.40409@in.ibm.com>
	 <1163453995.5940.11.camel@localhost.localdomain>
	 <4559C6A9.4070204@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-re2ZvGguFfcmNcNsPKLX"
Date: Wed, 15 Nov 2006 13:58:56 +1100
Message-Id: <1163559536.19171.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-re2ZvGguFfcmNcNsPKLX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-14 at 19:07 +0530, Srinivasa Ds wrote:
> Hi
> when I tried to hot plug a cpu on IBM bladecentre JS20 system,it dropped=20
> in to xmon.

How did you try to hot plug a cpu? Through sysfs/hmc/somethingelse ?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-re2ZvGguFfcmNcNsPKLX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFWoJwdSjSd0sB4dIRAl6CAKCkNTZtM+gCwweoXPu8GvuYaWHNLwCdGsRc
UwhN+dsj1gzY+GPwfC9sNpE=
=teKj
-----END PGP SIGNATURE-----

--=-re2ZvGguFfcmNcNsPKLX--

