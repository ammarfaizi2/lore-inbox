Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUGZLSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUGZLSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUGZLSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:18:20 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:2234 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265201AbUGZLSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:18:16 -0400
Message-ID: <4104E863.6070102@kolivas.org>
Date: Mon, 26 Jul 2004 21:17:55 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <200407261234.29565.rjwysocki@sisk.pl> <4104DD27.6050907@kolivas.org> <200407261254.01186.rjwysocki@sisk.pl> <4104E4ED.7030901@kolivas.org> <4104E750.60400@yahoo.com.au>
In-Reply-To: <4104E750.60400@yahoo.com.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25BBA947EDCA35E856BD4DE5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25BBA947EDCA35E856BD4DE5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Con Kolivas wrote:
> 
>> R. J. Wysocki wrote:
>>
>>> On Monday 26 of July 2004 12:29, Con Kolivas wrote:
>>>
> 
>>>> I think one knob is one knob too many already.
>>>
>>>
>>>
>>>
>>> Can you please tell me why do you think so?
>>
>>
>>
>> If you wanna discuss pedantics...
>>
>> In my ideal, nonsensical, impossible to obtain world we have an 
>> autoregulating operating system that doesn't need any knobs.
>>
> 
> Some thinks are fundamental tradeoffs that can't be autotuned.
> 
> Latency vs throughput comes up in a lot of places, eg. timeslices.
> 
> Maximum throughput via effective use of swap, versus swapping as
> a last resort may be another.

As I said... it was ideal, nonsensical, and impossible. Doesn't sound 
like you're arguing with me.

Con

--------------enig25BBA947EDCA35E856BD4DE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBBOhmZUg7+tp6mRURArvpAJ93fi9xH2HwFnDpThs+WCen/l/egwCaAvw8
us4t2Vk2z7LFf/qd5YlH2Ck=
=Z5of
-----END PGP SIGNATURE-----

--------------enig25BBA947EDCA35E856BD4DE5--
