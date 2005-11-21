Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVKUNDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVKUNDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVKUNDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:03:25 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:9645 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932294AbVKUNDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:03:24 -0500
Message-ID: <4381C57A.9030407@g-house.de>
Date: Mon, 21 Nov 2005 14:02:50 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dominik Brodowski <linux@dominikbrodowski.net>,
       Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Michael Krufky <mkrufky@m1k.net>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <Pine.LNX.4.61.0511182214200.4797@goblin.wat.veritas.com> <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins schrieb:
> So I'll go on a trawl through the source before finalizing the fix,
> but below is the patch you guys need.  Does this patch deal with your
> Bad page states too, Marc?  Does it help your mouse at all somehow?

yes, it fixes the very same issue (Bad page states) here too.

thank you,
Christian.
-- 
BOFH excuse #396:

Mail server hit by UniSpammer.
