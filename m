Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbUKJFVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUKJFVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 00:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKJFVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 00:21:46 -0500
Received: from imap.gmx.net ([213.165.64.20]:16024 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261877AbUKJFVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 00:21:20 -0500
X-Authenticated: #815327
Message-ID: <4191A549.9060602@gmx.de>
Date: Wed, 10 Nov 2004 06:21:13 +0100
From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WOL for sis900
References: <4183B6B0.7010906@gmx.de> <1100055532.25963.58.camel@localhost.localdomain>
In-Reply-To: <1100055532.25963.58.camel@localhost.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig99E09B220EDCD5393CBDF2B0"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99E09B220EDCD5393CBDF2B0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Rusty Russell wrote:
> On Sat, 2004-10-30 at 17:43 +0200, Malte Schröder wrote:
> 
>>Hello,
>>I have applied the patch from http://lkml.org/lkml/2003/7/16/88 manually 
>>to 2.6.7 (also works on 2.6.{8,9}) and have been using it since then.
>>Attached is a diff against 2.6.9.
> 
> 
> Want to change the MODULE_PARM to new-style module_param() calls, too?

Since I don't exactly know what this means and currently don't have the 
time to find out I don't think so.
And if WoL should be done using ethtool, my patch should be ignored and 
the one of Daniele Venzano (posted to netdev@oss.sgi.com) should be 
considered.

(Will gather some more background information before posting a patch 
next time ;) )

Greets :)
> 
> Thanks,
> Rusty.


-- 
---------------------------------------
Malte Schröder
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--------------enig99E09B220EDCD5393CBDF2B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkaVN4q3E2oMjYtURAhT3AJ91CPva2hAcVVA5cpX0RdUOcaVRAQCg2HSh
HJ752UxgPTB+SiIzmQMhgf4=
=7P1H
-----END PGP SIGNATURE-----

--------------enig99E09B220EDCD5393CBDF2B0--
