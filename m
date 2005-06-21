Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVFUVP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVFUVP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVFUVHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:07:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262360AbVFUU6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:58:33 -0400
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, Greg KH <greg@kroah.com>
In-Reply-To: <20050621131132.105ea76f.akpm@osdl.org>
References: <20050621062926.GB15062@kroah.com>
	 <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com>
	 <20050621131132.105ea76f.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NGp76us0yemCIzAI0YK6"
Organization: Red Hat, Inc.
Date: Tue, 21 Jun 2005 16:52:02 -0400
Message-Id: <1119387122.6465.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NGp76us0yemCIzAI0YK6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-21 at 13:11 -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> >  Or I can wait until you go next.  I didn't want these patches in the -=
mm
> >  tree as they would have caused you too much work to keep up to date an=
d
> >  not conflict with anything else due to the size of them.
>=20
> What happens if we merge it and then the storm of complaints over the
> ensuing four weeks makes us say "whoops, shouldna done that [yet]"?

so... disable the config option now. then wait 3 weeks. then do the
rest ;)

undoing the config change is easy compared to undoing the rest...


--=-NGp76us0yemCIzAI0YK6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCuH3ypv2rCoFn+CIRAh/2AJ9dhgBQVwF+oag53gGZU3kn4PJ9hACfUT6T
ZTIjV/0BjL/xd09Qj8c/8eI=
=sHAv
-----END PGP SIGNATURE-----

--=-NGp76us0yemCIzAI0YK6--

