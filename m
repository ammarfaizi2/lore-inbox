Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUC3X04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUC3X04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:26:56 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:16402 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id S261677AbUC3X0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:26:48 -0500
Message-ID: <406A020B.3010704@scssoft.com>
Date: Wed, 31 Mar 2004 01:26:03 +0200
From: Petr Sebor <petr@scssoft.com>
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com> <4069FFB1.3060503@pobox.com>
In-Reply-To: <4069FFB1.3060503@pobox.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC7B2BA50333B3351EC78C2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC7B2BA50333B3351EC78C2F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> oh, and are both disks SATA?

Both drives are SATA

> Or is the 37G drive a PATA drive on a PATA->SATA adapter (a.k.a. bridge)?

Nope.

> Do you have any special settings like BIOS RAID turned on, that might 
> interfere with things?

This thing is turned off. (at least I hope so... will check)

I'll try the patch you sent as soon as I reach the machine.

Thanks!

Best regards,
Petr


--------------enigDC7B2BA50333B3351EC78C2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAagIMir6eWjmOQ6cRAq/tAJ0eJpVi00TkrpN9fNnMePRP7xNjAACfRWqw
kaGauqbp1su7wUmpjEtLQ3I=
=M90m
-----END PGP SIGNATURE-----

--------------enigDC7B2BA50333B3351EC78C2F--
