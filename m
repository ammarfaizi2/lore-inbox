Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVANBYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVANBYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 20:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVANBWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 20:22:36 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:57239 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261720AbVANBTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 20:19:41 -0500
Message-ID: <41E71E25.20005@kolivas.org>
Date: Fri, 14 Jan 2005 12:19:33 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: 2.6.10-ck4
References: <200501131933.21021.adobriyan@mail.ru>
In-Reply-To: <200501131933.21021.adobriyan@mail.ru>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD9A37E5653D6C2E7BC2AA908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9A37E5653D6C2E7BC2AA908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alexey Dobriyan wrote:
> Problems rebooting here. Don't have them in 2.6.10 and 2.6.11-rc1.
> 
> If you want complete messages, just ask. I will write them down into 
> electronic form.
> 
> First time there was an unstoppable infinite loop of quickly moving USB 
> related messages. I only saw "[uhci_hcd]" string reliably. Can't reproduce.
> 
> Third time:

>  <0> Kernel panic - not syncing: Fatal exception in interrupt.
> 
> Second time:
> 
> [<c0113160>] do_page_fault+0x0/0x562

>  <0> Kernel panic - not syncing: Fatal exception in interrupt.

This is funny:

> Other than that everything seems to be ok. 

Is that like saying "the operation was a success but the patient died" ?

Sorry I have no idea what those are.

Cheers,
Con

--------------enigD9A37E5653D6C2E7BC2AA908
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5x4lZUg7+tp6mRURAovTAJsFX9uALosRehacBdB8taIEWkpSTwCeKebn
V1LUY5o1TZ10ruLfTdhFHF8=
=CKWG
-----END PGP SIGNATURE-----

--------------enigD9A37E5653D6C2E7BC2AA908--
