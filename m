Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUGJPS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUGJPS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUGJPS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:18:28 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:11666 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266289AbUGJPS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:18:26 -0400
Message-ID: <40F008B0.8020702@kolivas.org>
Date: Sun, 11 Jul 2004 01:18:08 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <20040710151455.GA29140@devserv.devel.redhat.com>
In-Reply-To: <20040710151455.GA29140@devserv.devel.redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB424B79CDF2322CEF422B165"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB424B79CDF2322CEF422B165
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> On Sun, Jul 11, 2004 at 01:12:28AM +1000, Con Kolivas wrote:
> 
>>I've conducted some of the old fashioned Benno's latency test on this 
> 
> 
> is that the test which skews with irq's disabled ? (eg uses normal
> interrupts and not nmi's for it's initial time inrq)

It probably is; in which case all these results would be useless, no?

http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz

Con

--------------enigB424B79CDF2322CEF422B165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8AiwZUg7+tp6mRURAtXjAJ9SJRqwaWYZwqgnbLMBRw/HYqyLzwCfd9M4
p+tSmGKDWUYvk1BbGe7szNU=
=JISt
-----END PGP SIGNATURE-----

--------------enigB424B79CDF2322CEF422B165--
