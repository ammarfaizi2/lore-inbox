Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRC3G7A>; Fri, 30 Mar 2001 01:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRC3G6u>; Fri, 30 Mar 2001 01:58:50 -0500
Received: from 4dyn151.delft.casema.net ([195.96.105.151]:1544 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130900AbRC3G6i>; Fri, 30 Mar 2001 01:58:38 -0500
Message-Id: <200103300657.IAA07806@cave.bitwizard.nl>
Subject: Re: EXT2-fs error
In-Reply-To: <20010329220630.A32834@khromy.lnuxlab.net> from khromy at "Mar 29,
 2001 10:06:30 pm"
To: khromy <khromy@khromy.ath.cx>
Date: Fri, 30 Mar 2001 08:57:48 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> Linux vingeren.girl 2.4.3-pre7 #5 Mon Mar 26 23:33:59 EST 2001 i686 unknown
> 
> EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576
> EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576
> 
> ^
> I got the following while rm -rf'ing my mozilla cvs checkout.  Deadly or not deadly?

Highly deadly. 

Your disk is dropping bits, or, more likely, your RAM. This is very,
very bad.

Can you compile 100 kernes without error?

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
