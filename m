Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLERPc>; Tue, 5 Dec 2000 12:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLERPW>; Tue, 5 Dec 2000 12:15:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51729 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129552AbQLERPL>;
	Tue, 5 Dec 2000 12:15:11 -0500
Message-Id: <200012051625.RAA02860@cave.bitwizard.nl>
Subject: Re: Serial Console
In-Reply-To: <Pine.LNX.4.30.0012051506030.31704-100000@rossi.itg.ie> from Paul
 Jakma at "Dec 5, 2000 03:14:44 pm"
To: Paul Jakma <paulj@itg.ie>
Date: Tue, 5 Dec 2000 17:25:35 +0100 (MET)
CC: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> perhaps linux-mips is just different? or i386 serial-console is
> incorrect?

No. serial console on i386 doesn't and should not block. 
We're constantly using serial consoles here, so I really think I've 
seen this work... .

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
