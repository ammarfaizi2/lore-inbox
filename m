Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUHIVMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUHIVMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUHIVLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:11:41 -0400
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:9866 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267226AbUHIVLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:11:13 -0400
Message-ID: <4117E863.7020703@kolivas.org>
Date: Tue, 10 Aug 2004 07:10:59 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408091338.i79DcauL010369@burner.fokus.fraunhofer.de>
In-Reply-To: <200408091338.i79DcauL010369@burner.fokus.fraunhofer.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCF712D11DEBE19042D21042"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCF712D11DEBE19042D21042
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joerg Schilling wrote:
>>>You should learn what "make sense" means, Linux-2.6 is a clear move away from 
>>>the demands of a Linux user who likes to write CDs/DVDs.
> 
> 
>>Could have fooled me. I'm a linux user who writes lots of cds and I had 
>>heaps of trouble scanning busses and trains and automobiles on the atapi 
>>interface till I could do a simple
> 
> 
>>dev=/dev/hdd
> 
> 
>>Seems they listened to this user.
> 
> 
> ever tried this with an audio CD?
> 
> geh.....

Great idea! Can you implement it please?

Cheers,
Con

--------------enigCCF712D11DEBE19042D21042
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBF+hmZUg7+tp6mRURAlRzAJ90ibmguQqpMQr1uIMTDEbWp3cb5wCeLDL1
uQubiwDfQTRbUEduytD9G1A=
=GuGN
-----END PGP SIGNATURE-----

--------------enigCCF712D11DEBE19042D21042--
