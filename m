Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLKEWz>; Sun, 10 Dec 2000 23:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbQLKEWq>; Sun, 10 Dec 2000 23:22:46 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:528 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129319AbQLKEWZ>; Sun, 10 Dec 2000 23:22:25 -0500
Message-ID: <3A344EFA.1CD056C@megapathdsl.net>
Date: Sun, 10 Dec 2000 19:50:18 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org
Subject: Re: INIT_LIST_HEAD marco audit
In-Reply-To: <390158470.976495326591.JavaMail.root@web346-wra.mail.com> <3A3441FC.28A2D2CA@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" wrote:
> 
> The follwing files probably need to be patched to use the
> DECLARE_TASK_QUEUE() macro and new tq_struct, but I don't have time
> right now to go through them.

Would someone who knows what to do send out a patch for
these two drivers?

	drivers/pcmcia/i82365.c
	drivers/pcmcia/tcic.c

Thanks!

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
