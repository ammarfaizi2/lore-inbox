Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUGTBiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUGTBiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 21:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUGTBiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 21:38:09 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:44030 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S265124AbUGTBiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 21:38:06 -0400
Message-ID: <40FC7778.2070909@hispalinux.es>
Date: Tue, 20 Jul 2004 03:38:00 +0200
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt 2.6.8-rc2-H4
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710075747.GA25052@elte.hu> <2a4f155d040710011041a95210@mail.gmail.com> <20040710082846.GA29275@elte.hu> <20040719103637.GA8924@elte.hu>
In-Reply-To: <20040719103637.GA8924@elte.hu>
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
| i've uploaded the latest (-H4) voluntary-preempt patch to:
|
|   http://redhat.com/~mingo/voluntary-preempt/
|
| Changes from -H3 to -H4:
|
|  - fixes the ext3 bug reported by Zwane Mwaikambo
|  - port to 2.6.8-rc2
|
| There are also patches are against 2.6.7-vanilla, 2.6.7-mm7 and
| 2.6.7-bk20.

With 2.6.8-rc2 I get this with loop module

	loop: Unknown symbol voluntary_resched

- --
Ram?n Rey Vicente       <ramon dot rey at hispalinux dot es>
jabber ID               <rreylinux at jabber dot org>
GPGid 9F28E377 - 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
===================================================================
"Copyright doesn't cover ideas; it's your expression of those
ideas." (Richard M. Stallman)
===================================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA/Hd4w4Wp058o43cRAlN3AJ4o3UMjamq7tsPyh1q29XbV9+ke/gCdFrJG
3X5SmTFL23bduwutltZw01o=
=kIAm
-----END PGP SIGNATURE-----
