Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUAQTUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAQTUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:20:00 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:48002 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266147AbUAQTT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:19:58 -0500
Subject: Re: [RFC] kill sleep_on
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40098251.2040009@colorfullife.com>
References: <40098251.2040009@colorfullife.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-54ZvOyYNgvRby0MLL5aW"
Organization: Red Hat, Inc.
Message-Id: <1074367188.4429.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Jan 2004 20:19:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-54ZvOyYNgvRby0MLL5aW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Any objections against killing it entirely? Or what about marking it as
> deprecated, as the first step towards killing it?

I have it marked like that in my tree. Lots of warnings... and
unfortionately about half are in "new" code so imo we can't mark it
deprecated early enough to prevent more of these bugs to enter the
kernel.

--=-54ZvOyYNgvRby0MLL5aW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACYrUxULwo51rQBIRAl+zAJ9eYx/lqyNOfF+AU0pckUUUd5RzHwCeIHn/
V96vq612HWSgUDgT3Np3lBE=
=eBHf
-----END PGP SIGNATURE-----

--=-54ZvOyYNgvRby0MLL5aW--
