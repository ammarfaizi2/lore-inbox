Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAVHxs>; Mon, 22 Jan 2001 02:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAVHx2>; Mon, 22 Jan 2001 02:53:28 -0500
Received: from 13dyn249.delft.casema.net ([212.64.76.249]:1554 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129413AbRAVHxR>; Mon, 22 Jan 2001 02:53:17 -0500
Message-Id: <200101220753.IAA12360@cave.bitwizard.nl>
Subject: Re: Is this kernel related (signal 11)?
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGOEJOCNAA.rmager@vgkk.com> from Rainer Mager
 at "Jan 22, 2001 02:17:53 pm"
To: Rainer Mager <rmager@vgkk.com>
Date: Mon, 22 Jan 2001 08:53:13 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Mager wrote:

> that it is likely a hardware or kernel problem. So, my question is,
> how can I pin point the problem? Is this likely to be a kernel
> issue?

No, not hardware. No not kernel. 

Harware problems are normally not reproducable. Can you attach a
debugger to your X server, and catch it when things go bad? (And
give the Xfree86 people a backtrace)

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
