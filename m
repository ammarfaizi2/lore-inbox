Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEW2L>; Fri, 5 Jan 2001 17:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRAEW1v>; Fri, 5 Jan 2001 17:27:51 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:5883 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S129267AbRAEW1n>; Fri, 5 Jan 2001 17:27:43 -0500
Date: Fri, 5 Jan 2001 22:28:04 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Subject: Poor Leonard... and Documentation/ question
Message-ID: <20010105222804.A2865@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -rub 2.4.0/CREDITS linux/CREDITS
--- 2.4.0/CREDITS       Fri Jan  5 09:00:34 2001
+++ linux/CREDITS       Fri Jan  5 09:00:34 2001
@@ -3014,5 +3014,5 @@
 # Don't add your name here, unless you really _are_ after Marc
 # alphabetically. Leonard used to be very proud of being the
 # last entry, and he'll get positively pissed if he can't even
-# be second-to-last.  (and this file really _is_ supposed to be
+# be third-to-last.  (and this file really _is_ supposed to be
 # in alphabetic order)


Also, is there a seperate mailing list, or web site for the
DocBookization of Documentation/? Is the plan to DocBookize everything
under there? It's a bit of a mess, currently... there's not a naming
convention much less a formating one. I'm interested in helping out
since my C skills are less dangerous when set to read-only.

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
