Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQKRLhl>; Sat, 18 Nov 2000 06:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQKRLhc>; Sat, 18 Nov 2000 06:37:32 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:20685 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129352AbQKRLhX>; Sat, 18 Nov 2000 06:37:23 -0500
Date: Sat, 18 Nov 2000 12:07:15 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: ORACLE and 2.4-test10
Message-ID: <20001118120715.A6449@iapetus.localdomain>
In-Reply-To: <3A157E06.37255710@evision-ventures.com> <E13wq1g-0000zo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E13wq1g-0000zo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Nov 17, 2000 at 06:14:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 06:14:14PM +0000, Alan Cox wrote:
> SHM is resolved but O_SYNC is not yet fixed. You could therefore easily lose
> your entire database

I assume 2.2.18-pre-latest is ok?
Some oracle doc still refers to 2.0.34

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
