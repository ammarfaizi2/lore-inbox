Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132974AbRDJQvR>; Tue, 10 Apr 2001 12:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbRDJQvK>; Tue, 10 Apr 2001 12:51:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132974AbRDJQuw>; Tue, 10 Apr 2001 12:50:52 -0400
Subject: Re: Garbage-collection patches for Configure.help
To: esr@thyrsus.com
Date: Tue, 10 Apr 2001 17:52:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        esr@snark.thyrsus.com (Eric S. Raymond), torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010410124449.A32432@thyrsus.com> from "Eric S. Raymond" at Apr 10, 2001 12:44:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n1NJ-0004be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Im currently working on getting the arch stuff ready to merge with Linus and
> > this patch will just make it a nightmare.
> 
> I withdraw it, then.  Would you please do the renames in your patch?  
> Those ought to go in, at least.
> 
> CONFIG_ARCH_EBSA285				CONFIG_ARCH_EBSA285_HOST
> CONFIG_ISDN_DRV_EICON_STANDALONE		CONFIG_ISDN_DRV_EICON_DIVAS
> CONFIG_MAC_KEYBOARD				CONFIG_ADB_KEYBOARD
> 
> The duplicate-removal stuff in my second patch ought to still be good, also.

The second patch is fine, its duplicating what I would eventually have sent
to Linus so causes no problems.

CONFIG_EBSA_285_HOST is right in my tree
Just fixed ADB_KEYBOARD as you suggest
CONFIG_ISDN_DRV_EICON_STANDALONE doesnt appear in my tree

