Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUHILKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUHILKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUHILKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:10:16 -0400
Received: from mail015.syd.optusnet.com.au ([211.29.132.161]:61338 "EHLO
	mail015.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266484AbUHILKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:10:08 -0400
Message-ID: <41175B6E.7060308@kolivas.org>
Date: Mon, 09 Aug 2004 21:09:34 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
In-Reply-To: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAF6DF5F36577672C4BA68734"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF6DF5F36577672C4BA68734
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joerg Schilling wrote:
>>From axboe@suse.de  Fri Aug  6 17:10:35 2004
>>We try, when they make sense...
> 
> 
> You should learn what "make sense" means, Linux-2.6 is a clear move away from 
> the demands of a Linux user who likes to write CDs/DVDs.

Could have fooled me. I'm a linux user who writes lots of cds and I had 
heaps of trouble scanning busses and trains and automobiles on the atapi 
interface till I could do a simple

dev=/dev/hdd

Seems they listened to this user.

Cheers,
Con

--------------enigAF6DF5F36577672C4BA68734
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBF1txZUg7+tp6mRURAlGxAJ970bDDP89DfKXjYuJM21yeTJlvugCcCqLo
bWJUyESBrwYdKXAc3s6UVD0=
=+Z5L
-----END PGP SIGNATURE-----

--------------enigAF6DF5F36577672C4BA68734--
