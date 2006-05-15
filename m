Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWEOQxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWEOQxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWEOQxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:53:23 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:22270 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964892AbWEOQxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:53:22 -0400
Message-ID: <4468B1FB.3020007@stesmi.com>
Date: Mon, 15 May 2006 18:53:15 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org>	 <20060512122116.152fbe80.rdunlap@xenotime.net>	 <4464E079.1070307@stesmi.com> <1147703159.26686.33.camel@localhost.localdomain>
In-Reply-To: <1147703159.26686.33.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig9A9DA24F7D1368D296F2E095"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A9DA24F7D1368D296F2E095
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Gwe, 2006-05-12 at 21:22 +0200, Stefan Smietanowski wrote:
> 
>>Ok, maybe not PMS ?
>>
>>Can you imagine a bug report from someone that "has problem with PMS"?
>>:)
> 
> We've had a driver for the pms card for many years and nobody over the
> age of about 18 has afaik found it amusing.

Depends, I never heard of the pms card but I do have this tingling
feeling that some actually will hear of and/or use port multipliers
for SATA meaning that "not many heard of the pms card so not many
over the age of 18 found it amusing" but not the same is true
for port multipliers.

// Stefan

--------------enig9A9DA24F7D1368D296F2E095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEaLH/Brn2kJu9P78RA8hVAKCFkmtbuRPxEAJ2TIdUEDU/NTUZ2gCdEd+B
PB0rB+uSu8kp8hStdGG/yJI=
=6is0
-----END PGP SIGNATURE-----

--------------enig9A9DA24F7D1368D296F2E095--
