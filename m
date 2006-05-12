Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWELTiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWELTiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWELTiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:38:16 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:61167 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750910AbWELTiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:38:16 -0400
Message-ID: <4464E423.6050504@stesmi.com>
Date: Fri, 12 May 2006 21:38:11 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 101551.753@compuserve.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Nee guidance for bug report on LKML
References: <200605122128.24633.it21@arcor.de>
In-Reply-To: <200605122128.24633.it21@arcor.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig891573C59FCCC07D4FAD768F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig891573C59FCCC07D4FAD768F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Foli Ayivoh wrote:
> Hi,
> 
> have a problem with HighPoint HPT372A/N IDE controller at boot time (kernel oops/panic).
>  (On Fedora Core 5 with Kernel 2.6.15-1.2054_FC5)
> To whom should I send an bug report?

First upgrade to the latest FC5 kernel (2.6.16-1.2108), and try again.

If it still doesn't work, try the latest plain kernel (2.6.16.x or
2.6.17-rc) and try again. If it still doesn't work, Send it to the
linux-ide list.

Even if you don't try the latest plain kernel, upgrade to latest
FC5 kernel before sending the bugreport to linux-ide.

// Stefan

--------------enig891573C59FCCC07D4FAD768F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZOQmBrn2kJu9P78RA6fGAKCJMXcorw5vICeYR2w9eBrEVvGT2ACfWTiH
dYxnFWbJY+vU4O3pP7o5Qf4=
=AZLH
-----END PGP SIGNATURE-----

--------------enig891573C59FCCC07D4FAD768F--
