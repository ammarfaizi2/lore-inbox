Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRBLN6Q>; Mon, 12 Feb 2001 08:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRBLN5z>; Mon, 12 Feb 2001 08:57:55 -0500
Received: from limes.hometree.net ([194.231.17.49]:33088 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129495AbRBLN5x>; Mon, 12 Feb 2001 08:57:53 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2001 13:39:41 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <968p2t$lfh$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <E14S01O-0004Su-00@the-village.bc.nu>, <oupvgqhkn8f.fsf@pigdrop.muc.suse.de>
Reply-To: hps@tanstaafl.de
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de (Andi Kleen) writes:

>to the low level file system for efficient lookup (actually is all not 
>too difficult to implement, just requires very uncodefreezefriendly changes
>to nfsd) 

Well, at least I would really prefer a change for 2.4.x the sooner the
better as I will never ever want to repeat the NFS nightmare from
2.2. I prefer a working NFS on Reiser over a non working, but
codefreezed at any time. ;-)

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
