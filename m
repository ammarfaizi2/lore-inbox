Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbUKHAiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbUKHAiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUKHAiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:38:09 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:40935 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261283AbUKHAiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:38:03 -0500
Message-ID: <418EBFE5.5080903@kolivas.org>
Date: Mon, 08 Nov 2004 11:37:57 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch>
In-Reply-To: <20041108003323.GE5360@magma.epfl.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig80C87EDC497CFEAD7183F72D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80C87EDC497CFEAD7183F72D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gregoire Favre wrote:
> On Mon, Nov 08, 2004 at 11:08:11AM +1100, Con Kolivas wrote:
> 
> 
>>>>>I use DVB with VDR, but I can do the crash all the time without VDR, all
>>>>>I have to do is to have xawtv running and having a process that write
>>>>>fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
>>>>>same result). If I don't have xawtv running I can't make crashing my
>>>>>system which is rock stable :-)
>>>>
>>>>Is xawtv running as root or with real time privileges? That could do it.
> 
> 
>>What does 'top' show as the PRI for xawtv?
> 
> 
> I just started it and see 16 as priority in top. Should I renice it or
> start it another way ?

No I was just excluding whether you were running real time or not. You 
are not, so that excludes that as the cause of your problem. I have no 
further ideas though I'm afraid.

Cheers,
Con

--------------enig80C87EDC497CFEAD7183F72D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjr/lZUg7+tp6mRURAgvvAKCOxzB08Vw0LswDpZzfsai1ccL97gCfXVlk
rJEWEMYl3xmNIH7bUOvS/60=
=L2KZ
-----END PGP SIGNATURE-----

--------------enig80C87EDC497CFEAD7183F72D--
