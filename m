Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKHXt1>; Wed, 8 Nov 2000 18:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKHXtH>; Wed, 8 Nov 2000 18:49:07 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:58119 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129047AbQKHXtF>; Wed, 8 Nov 2000 18:49:05 -0500
Date: Wed, 8 Nov 2000 15:49:14 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108154914.B28101@twiddle.net>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <20001108142513.A5244@jurassic.park.msu.ru> <20001108093744.D27324@twiddle.net> <20001109010336.A1367@jurassic.park.msu.ru> <3A09D72A.C2730D0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A09D72A.C2730D0@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 05:43:54PM -0500, Jeff Garzik wrote:
> FWIW, I just tested rth's update of your path on my x86 SMP box, and a
> laptop with two CardBus bridges (two CardBus slots).  Both worked
> fine...

x86 doesn't use this code at all.  Only alpha, arm, and mips.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
