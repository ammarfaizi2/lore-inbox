Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130000AbQK2LTb>; Wed, 29 Nov 2000 06:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130138AbQK2LTV>; Wed, 29 Nov 2000 06:19:21 -0500
Received: from Prins.externet.hu ([212.40.96.161]:22288 "EHLO
        prins.externet.hu") by vger.kernel.org with ESMTP
        id <S130000AbQK2LTK>; Wed, 29 Nov 2000 06:19:10 -0500
Date: Wed, 29 Nov 2000 11:48:21 +0100 (CET)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 36bit mtrrs work! (2.4.0-test12-pre3)
In-Reply-To: <Pine.LNX.4.21.0011291035290.841-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.02.10011291141240.23503-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> Hi,
> 
> Just to let people know that 2.4.0-test12-pre3 behaves much better than
> earlier versions on my 6G RAM machine. Not only /proc/mtrr is correctly
> showing all 6G cached for write-back but also I so far I never had to
> up/down one of the eepro100 interfaces to get it to work -- something I
> hda to do in all previous versions. (without david-mtrr.patch)
> 
> Regards,
> Tigran
> 
Excellent! :-))))

BTW what test12-pre2/3 contains is David Wragg's work, updated
to HPA's CPUID code that is in test11. Linus incorrectly
attributed to me the whole patch in test12.log.

Regards,
Zoltan Boszormenyi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
