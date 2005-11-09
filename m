Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKIPs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKIPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKIPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:48:28 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:34194 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750721AbVKIPs2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:48:28 -0500
Subject: Re: New Linux Development Model
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: "Wed, 9 Nov 2005 13:03:07 +0100" <grundig@teleline.es>
Cc: marado@isp.novis.pt, Linux-kernel@vger.kernel.org, fawadlateef@gmail.com,
       s0348365@sms.ed.ac.uk, hostmaster@ed-soft.at, jerome.lacoste@gmail.com,
       carlsj@yahoo.com
In-Reply-To: <20051109130307.bd1b2cce.grundig@teleline.es>
References: <1131500868.2413.63.camel@localhost>
	 <1131534496.8930.15.camel@noori.ip.pt> <1131535832.2413.75.camel@localhost>
	 <20051109130307.bd1b2cce.grundig@teleline.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5VfcSKuV94irBd7cCNdk"
Date: Wed, 09 Nov 2005 16:49:17 +0100
Message-Id: <1131551357.2413.80.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5VfcSKuV94irBd7cCNdk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 13:03 +0100, Wed, 9 Nov 2005 13:03:07 +0100 wrote:
> El Wed, 09 Nov 2005 12:30:32 +0100,
> Ian Kumlien <pomac@vapor.com> escribi=F3:
>=20
> > The 'stable' version that got merged is more or less useless to people
> > who are smart about their wlans. And on a side note, even the firmware
> > has improved since then.
>=20
> People who is smart about their wlans is smart enought to update their
> kernels to use the new and possibily more unstable version. What's the
> problem? People maintaining the main tree may have a different (and
> valid) view on this issue.=20

Since it out of tree, it's not a issue of 'updating' a kernel, it's more
of a issue of making it compile with a kernel.
(which if you read the original post was one of the problems mentioned.)

And, yes, they might have a valid view, but the kernel also has
"experimental" features, why not merge a driver that can be used, mark
it as experimental until it's merged with a stable rel. The issue of
getting the first rel in to the kernel is that all of the sudden more
developers starts hacking away on it and the original developers have to
keep it all in sync (as i mentioned before).

> People is allowed to have different opinions than you, deal with it.

And that applies to me to, now deal with it.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-5VfcSKuV94irBd7cCNdk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDchp97F3Euyc51N8RAviZAJkB2tSH5bylo3tmwAvOD1s78wTi6QCgiEWm
bWZIZ0msEuaeMCXll/7ZqPY=
=fpJ6
-----END PGP SIGNATURE-----

--=-5VfcSKuV94irBd7cCNdk--

