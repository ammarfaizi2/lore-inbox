Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbQKGJhg>; Tue, 7 Nov 2000 04:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbQKGJh0>; Tue, 7 Nov 2000 04:37:26 -0500
Received: from 4dyn176.delft.casema.net ([195.96.105.176]:64774 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129562AbQKGJhR>; Tue, 7 Nov 2000 04:37:17 -0500
Message-Id: <200011070935.KAA03412@cave.bitwizard.nl>
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <200011070533.VAA02179@pizda.ninka.net> from "David S. Miller" at
 "Nov 6, 2000 09:33:25 pm"
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 7 Nov 2000 10:35:21 +0100 (MET)
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Linux resends 21:557, Windows95 (finally) acknowledges it.
> 
> Looking at the equivalent 220 traces, the only difference appears to
> be that the packets are not getting dropped.

This smells of "wrong checksums getting generated", in my opinion. 

(This is not my field of expertise. I'll keep my trap shut from now
on, OK?)

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
