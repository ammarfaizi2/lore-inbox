Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVANBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVANBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVANBFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:05:49 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:56548 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261843AbVANBCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:02:51 -0500
Message-ID: <41E71A27.2020103@kolivas.org>
Date: Fri, 14 Jan 2005 12:02:31 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: Re: 2.6.10-ck4
References: <41E680A2.3010000@kolivas.org> <41E6FC6D.8010909@lanil.mine.nu>
In-Reply-To: <41E6FC6D.8010909@lanil.mine.nu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig576791D19F35AEFEB6EFE3BB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig576791D19F35AEFEB6EFE3BB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christian Axelsson wrote:
> Are there any plans on putting back reiser4 in -ck?
> Im looking for a patchet that has reiser4 and that is more friendly 
> towards ati-drivers and other 3rd-party modules (no massive api-changes).

The -cko and -nitro patches use -ck as their base and add reiser4. Wait 
till they sync up with the latest ck and use those (the url is available 
from my web page).

Cheers,
Con

--------------enig576791D19F35AEFEB6EFE3BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5xonZUg7+tp6mRURAmCfAJ4mgUkQWFi++/4iiLnoEpOm0pwFnQCfQuhQ
eRf92Cv4XNepZyxB0XMatsg=
=fhUl
-----END PGP SIGNATURE-----

--------------enig576791D19F35AEFEB6EFE3BB--
