Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLMX7O>; Wed, 13 Dec 2000 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQLMX7E>; Wed, 13 Dec 2000 18:59:04 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:49834 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129383AbQLMX6q>;
	Wed, 13 Dec 2000 18:58:46 -0500
Message-ID: <3A380613.22D085CC@voicenet.com>
Date: Wed, 13 Dec 2000 18:28:19 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE bugs for intel 440LX chipset in Test12?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All I can say right now is that enabling DMA on a 440LX chipset with
2.4.0-test12  or any other kernel I can remember has caused DMA timeout
and ide-reset problems.  Disabling dma on the harddrives doesn't help
that much either, I still get ide resets.   What I'm looking for right
now is some information on how to log what the kernel recieves from the
harddrive and possibly what it sends so I can give rik some better
information on what's going on in this chipset.  Thanks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
