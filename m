Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbUJYQFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUJYQFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUJYQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:00:42 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:51178 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S261957AbUJYPc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:32:29 -0400
Date: Mon, 25 Oct 2004 17:29:21 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041025152921.GA25154@thundrix.ch>
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1098442636l.17554l.0l@hh>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Fri, Oct 22, 2004 at 10:57:16AM +0000, Helge Hafting wrote:
> 24-bit color
> ------------

Why don't you use 32-bit colors?  24-bit packed pixels are a pita, and
a lot of OpenGL hardware doesn't support 24bpp. You might atcually get
better graphics/performance/etc. if you  stick to 32bpp. Only that the
framebuffer size increases by 1/3rd.

			    Tonnerre

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBfRvR/4bL7ovhw40RAoo9AKCieobgSdujjCODIWK8QgDTU6+jcgCeKLcQ
sq/7aR9KShK2ZOChfrxIaPI=
=5YUk
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
