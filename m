Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129656AbQKSSF0>; Sun, 19 Nov 2000 13:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129653AbQKSSFG>; Sun, 19 Nov 2000 13:05:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:43524 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129157AbQKSSE5>;
	Sun, 19 Nov 2000 13:04:57 -0500
Message-ID: <3A180F1E.83F6D925@mandrakesoft.com>
Date: Sun, 19 Nov 2000 12:34:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: peter@rottengatter.de
CC: linux-kernel@vger.kernel.org, perot@arisia.rottengatter.de
Subject: Re: PROBLEM: 3c509 driver broken in 2.4.0-test10, not in -test9
In-Reply-To: <E13xYFr-0000FO-00@pausch-111.htp-tel.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Rottengatter wrote:
> 
> Sorry for using this address, there does not appear to be a special maintainer
> for the 3c509 network driver.
> 
> 1.
> 3c509 driver broken in 2.4.0-test10, not in -test9
> 
> 2.
> The 3c509 network driver worked fine for decades almost ;-) that is 2.0.x,
> 2.2.x, and 2.4.0-test up to 9. In 2.4.0-test10 it ooooopes upon modprobing.
> lsmod says "initializing" in the 3c509 entry, forever.
> 
> 3.
> 3c509, 3C509, Ethernet, networking, 2.4.0-test10

fixed in test11-preXX

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
