Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUHTOxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUHTOxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHTOxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:53:11 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:43967 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268203AbUHTOvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:51:41 -0400
Message-ID: <41260FE7.4070407@kolivas.org>
Date: Sat, 21 Aug 2004 00:51:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeremy@goop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] dothan speedstep fix
References: <4125A036.8020401@kolivas.org> <1093009108.30968.43.camel@localhost.localdomain>
In-Reply-To: <1093009108.30968.43.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD041C81374BCFE12689D11F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD041C81374BCFE12689D11F1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Gwe, 2004-08-20 at 07:54, Con Kolivas wrote:
> 
>>Hi Jeremy
>>
>>My new dothan cpu comes up as stepping 6. This patch fixes speedstep 
>>support for my laptop unless it can come up as multiple stepping values? 
>>Now all I need is for a way to make it report the correct L2 cache.
> 
> 
> The patch I posted to l/k a few minutea ago should fix the L2 cache
> reporting. 

Looks like you preempted DaveJ by a handful of emails.

Both patches look good (especially since they're identical ;))

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.70GHz
stepping        : 6
cpu MHz         : 1700.414
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca 
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
bogomips        : 3366.91


Thanks!

Cheers,
Con

--------------enigD041C81374BCFE12689D11F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJg/qZUg7+tp6mRURAk/YAJ0e0e3oKVOydfHYb7lfp10y/3ZvHACeNBYt
rMQqNj0P6Kp35uhbQbFGqA4=
=vQBs
-----END PGP SIGNATURE-----

--------------enigD041C81374BCFE12689D11F1--
