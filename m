Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbULYXJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbULYXJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 18:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbULYXJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 18:09:43 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:29574 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261592AbULYXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 18:09:27 -0500
Message-ID: <41CDF31E.8070907@kolivas.org>
Date: Sun, 26 Dec 2004 10:09:18 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in.tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc> <41CDB551.1090608@tmr.com>
In-Reply-To: <41CDB551.1090608@tmr.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79A19D6DA34D9F755BD4E91C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79A19D6DA34D9F755BD4E91C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bill Davidsen wrote:
> Rajsekar wrote:
> 
>> I would like to try out the SCHED_BATCH.  Unfortunately, I am not able to
>> find a patch for my kernel.  Could someone enlighten me on this?
>>
>> I am running 2.6.10-rc1-mm2 with staircase scheduler patch.  My `uname 
>> -a'
>> output is:
>>
>> Linux rajsekar.pc 2.6.10-rc1-mm2staircase #2 Sat Dec 4 10:49:31 IST 
>> 2004 i686 AuthenticAMD unknown GNU/Linux
>>
> See the announcement of 2.6.10-ck1, that has what you want. However, you 
> want to read the whole thread, as there is one patch WRT swap_token 
> which you may want to revert.

That patch is harmless so there is no need to revert it.

Cheers,
Con

--------------enig79A19D6DA34D9F755BD4E91C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBzfMeZUg7+tp6mRURAuCbAKCGZ+PBFeWFn63+Eytt+SX9sEL77ACfaatf
mn9iqrFjvIK0fDIpOrElwuU=
=4zwM
-----END PGP SIGNATURE-----

--------------enig79A19D6DA34D9F755BD4E91C--
