Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136746AbRAHE5o>; Sun, 7 Jan 2001 23:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136763AbRAHE5e>; Sun, 7 Jan 2001 23:57:34 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:5623 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S136746AbRAHE5b>; Sun, 7 Jan 2001 23:57:31 -0500
Date: Sun, 7 Jan 2001 22:57:30 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Cc: axel@uni-paderborn.de
Subject: [PATCH] More Configure.help fixes
Message-ID: <20010107225730.A8883@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dag Wieers caught all the double word's in Configure.help (from the
looks of the patch we're quite a bunch of stutterers), here's another
patch that catches mainly some combined words, a '2.3' -> '2.4', and
inproper capitalizations.

Also, two of the translation's for Configure.help have stale URL's...
I've XXX'd them, and sent a mail to the addresses for the maintainers
of the Spanish and Italian translation to see if there is a new URL.

The patch applies to 2.4.0 clean and to -ac4 with a bunch of offset
warnings, but manages to match all the hunks. (go, patch!)

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
