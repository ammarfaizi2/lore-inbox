Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132309AbQK3CwB>; Wed, 29 Nov 2000 21:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131375AbQK3Cvw>; Wed, 29 Nov 2000 21:51:52 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25107 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130372AbQK3Cvq>;
        Wed, 29 Nov 2000 21:51:46 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: another problem disappeared 
In-Reply-To: Your message of "Thu, 30 Nov 2000 01:28:13 BST."
             <UTC200011300028.BAA150956.aeb@aak.cwi.nl> 
Date: Thu, 30 Nov 2000 12:45:11 +1100
Message-Id: <20001130014521.862D78120@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <UTC200011300028.BAA150956.aeb@aak.cwi.nl> you write:
> Recently I muttered a bit about the fact that
> with 2.4.0test11 masquerading, the first packet
> that was to be forwarded crashes the kernel. Always.

Yes, I was on the plane when I read your report, but I can't reproduce
this.  I use masquerading every day (my laptop lives in its own
masqueraded subnet), currently test10:

Linux penicillin 2.4.0-test10 #1 SMP Fri Nov 10 12:31:21 EST 2000 i686 unknown  
> (I am still a bit curious: did other people see this?
> Did someone fix a known problem with net(filter) or say /proc?
> It would be a pity if this disappeared by coincidence
> and appears again next month.)

I've no other reports, and people are using this in production.
That's why it was so puzzling...

Cheers,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
