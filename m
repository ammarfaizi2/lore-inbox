Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUHTNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUHTNrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHTNrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:47:10 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:17823 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267352AbUHTNrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:47:03 -0400
Date: Fri, 20 Aug 2004 15:46:15 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for modules _and_ built-in code
Message-ID: <20040820134615.GC16660@thundrix.ch>
References: <20040801165407.GA8667@dominikbrodowski.de> <1091426395.430.13.camel@bach> <20040802214710.GB7772@dominikbrodowski.de> <1092858948.8998.47.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <1092858948.8998.47.camel@nosferatu.lan>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Aug 18, 2004 at 09:55:49PM +0200, Martin Schlemmer wrote:
> PS: If needed, I can try to get some time to leave it up not
>     in X ...

Try this in xorg.conf:

Section "Device"
	Identifier	"Generic VESA interface"
	Driver		"vesa"
EndSection

So you can have both X and a debuggable kernel.

			Tonnerre

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBJgCm/4bL7ovhw40RAqvrAJ9TE0L1Z0puJtYJ9ba0cXuLMYdzYwCdFHTp
JoUPsV5eosP0m8Da6BLa8OQ=
=If9B
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
