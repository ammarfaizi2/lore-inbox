Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130850AbRAIV7F>; Tue, 9 Jan 2001 16:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRAIV6z>; Tue, 9 Jan 2001 16:58:55 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:39754
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129436AbRAIV6q>; Tue, 9 Jan 2001 16:58:46 -0500
Date: Tue, 9 Jan 2001 22:58:38 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Patch for drivers/net/rcpci45.c updated to 2.4.0
Message-ID: <20010109225838.C945@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have updated my patch for drivers/net/rcpci45.c to 2.4.0. It can
be found at www.jaquet.dk/kernel/patches/rcpci.patch.gz. Besides
being rediffed it sports some more resource checks compared to the
last one (mentioned in http://marc.theaimsgroup.com/?l=linux-kernel&
m=97743837428000&w=2).

If somebody would like me to split this up for easier digestion/
acceptance I am willing to do so. Especially if a magic incantation
on how to split a large diff up into smaller (but line-number wise
interwoven) diffs were provided.
-- 
        Rasmus(rasmus@jaquet.dk)

You know how dumb the average guy is?  Well, by  definition, half
of them are even dumber than that.
            -- J.R. "Bob" Dobbs 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
