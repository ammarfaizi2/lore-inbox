Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJOJIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJOJIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 05:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUJOJIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 05:08:07 -0400
Received: from imap.gmx.net ([213.165.64.20]:9675 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267521AbUJOJID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 05:08:03 -0400
X-Authenticated: #4512188
Message-ID: <416F936C.8010007@gmx.de>
Date: Fri, 15 Oct 2004 11:07:56 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040929)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 038 release
References: <20041014003936.GA8810@kroah.com>
In-Reply-To: <20041014003936.GA8810@kroah.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig946008D615FF51651A7D724C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig946008D615FF51651A7D724C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

going from udev-036 to 038 on gentoo resulted in following problem for me:

I load the nvidia module via /etc/modules.autoload.d/kernel-2.6. With 
udev-036 the device nodes eventually were created fast enough so that 
kdm could start. With udev-038 it is not the case. The boot ends at the 
log-in, and I have to manually start kdm.

What is the right way to get this going?

Cheers,

Prakash

--------------enig946008D615FF51651A7D724C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBb5NwxU2n/+9+t5gRAkLaAKCwNb18UpJEghmo2I7IWKwY2P+0gQCdGr4W
F7a8iBWpnGxB2+tfzmv0c4o=
=tHnC
-----END PGP SIGNATURE-----

--------------enig946008D615FF51651A7D724C--
