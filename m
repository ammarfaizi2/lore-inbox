Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKINRx>; Thu, 9 Nov 2000 08:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQKINRn>; Thu, 9 Nov 2000 08:17:43 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:4391 "EHLO [62.161.177.33]")
	by vger.kernel.org with ESMTP id <S129121AbQKINRb>;
	Thu, 9 Nov 2000 08:17:31 -0500
From: Benjamin Herrenschmidt <bh40@calva.net>
To: Derrik Pates <dpates@andromeda.dsdk12.net>
Cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: B/W G3 - big IDE problems with 2.4.0-test10
Date: Thu, 9 Nov 2000 14:17:01 +0100
Message-Id: <19341004064845.6646@192.168.1.2>
In-Reply-To: <Pine.LNX.4.30.0011082252370.28457-100000@andromeda.dsdk12.net>
In-Reply-To: <Pine.LNX.4.30.0011082252370.28457-100000@andromeda.dsdk12.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 8 Nov 2000, Andre Hedrick wrote:
>
>> What is your chipset, CMD646 rev 5 Ultra DMA 33 ???
>
>Yep. I've tried building with the CMD64x driver, and that didn't help
>matters, if you were wondering. Any thoughts?

Did you try the bitkeeper PPC kernel ? (or Paul Mackerras rsync tree ?)

Not all PPC patches have been merged in Linus tree yet. There were some
resource assignement issues that were fixed only recently.

Ben.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
