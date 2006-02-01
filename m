Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWBAMxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWBAMxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBAMxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:53:23 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:59869 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932216AbWBAMxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:53:23 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Wed, 1 Feb 2006 22:49:52 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <84144f020602010438n3a1b50b3r3d2db9c84da94166@mail.gmail.com>
In-Reply-To: <84144f020602010438n3a1b50b3r3d2db9c84da94166@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2250854.oUttEiYquT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602012249.56963.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2250854.oUttEiYquT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 22:38, Pekka Enberg wrote:
> On 2/1/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > The name is currently mostly historical, from the time when these
> > components could be built as kernel modules.
>
> I think suspend_plugin would be a nicer name. Your code is even using
> the term 'plugin' and 'filter' instead of module in many places.

Hmm. Thought I got rid of all mentions of 'plugin'. I was trying to follow=
=20
Dave M's advice from LCA :). Filters are slightly different - they're the=20
modules that do the encryption or compression, as opposed to the writers th=
at=20
do the I/O.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2250854.oUttEiYquT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4K50N0y+n1M3mo0RAvBgAJwPfHbHJfBPlFzpWPvdner/ivj7lgCeIVYF
fFKo5vTTH8YpovgUovHOzm0=
=9Tu4
-----END PGP SIGNATURE-----

--nextPart2250854.oUttEiYquT--
