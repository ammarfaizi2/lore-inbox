Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135783AbRAGFVp>; Sun, 7 Jan 2001 00:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135817AbRAGFVf>; Sun, 7 Jan 2001 00:21:35 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:18952 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135783AbRAGFVZ>;
	Sun, 7 Jan 2001 00:21:25 -0500
Message-ID: <3A580BA9.ADAA2B97@candelatech.com>
Date: Sat, 06 Jan 2001 23:24:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumissionpolicy!)
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 

> Not to stray from the subject, Ben's effort is still needed. I think real
> numbers are useful instead of claims like it "displayed faster"

A single #define near the top of the patch will turn it on/off, so
benchmarking should be fairly easy.  Please suggest benchmarks you
consider valid.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
