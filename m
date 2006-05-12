Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWELTWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWELTWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWELTWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:22:44 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:52128 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751181AbWELTWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:22:43 -0400
Message-ID: <4464E079.1070307@stesmi.com>
Date: Fri, 12 May 2006 21:22:33 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net>
In-Reply-To: <20060512122116.152fbe80.rdunlap@xenotime.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig33DF01E9D9551B443CA7D3C6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33DF01E9D9551B443CA7D3C6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
>>
>>* New error handling
>>* IRQ driven PIO (from Albert Lee)
>>* SATA NCQ support
>>* Hotplug support
>>* Port Multiplier support
> 
> 
> BTW, we often use PM to mean Power Management.
> Could we find a different acronym for Port Multiplier support,
> such as PMS or PX or PXS?

Ok, maybe not PMS ?

Can you imagine a bug report from someone that "has problem with PMS"?
:)

// Stefan

--------------enig33DF01E9D9551B443CA7D3C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZOCBBrn2kJu9P78RA+CxAJ4hHJxiGyzBUD51dQFmcwF+EqkaRwCgtHtH
iVl8IPzYy1m6wjOlO7qmjb0=
=bhYv
-----END PGP SIGNATURE-----

--------------enig33DF01E9D9551B443CA7D3C6--
