Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUIGX1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUIGX1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUIGX1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:27:16 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9877 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268759AbUIGX1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:27:04 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Adrian Bunk <bunk@fs.tum.de>
Date: Wed, 8 Sep 2004 09:26:38 +1000
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.9-rc1-mm4: small LOCALVERSION help text corrections
Message-ID: <20040907232638.GC18970@cse.unsw.EDU.AU>
References: <20040907020831.62390588.akpm@osdl.org> <20040907184314.GA2454@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20040907184314.GA2454@fs.tum.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 07, 2004 at 08:43:14PM +0200, Adrian Bunk wrote:
> -	  The string you set here will be appended after the contents of=20
> -	  any files with a filename matching localversion* in your=20

Thanks,

Stupid quoted printable; in case anyone is wondering, you have to tell
mutt to explictly *not* use quoted printable with GPG signing by
setting pgp_strict_enc=no.  If you're going to try and send patches
inline with your message (as suggested by
http://linux.yyz.us/patch-format.html) and you want them gpg signed,
you probably want it off!

-i

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBPkOuWDlSU/gp6ecRAvxyAKDK4uoAQ/NTkdErIhHqbAEEevCJSgCg3gE/
svoqsw5q6Oyl+hv657TfXDI=
=Ha9V
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
