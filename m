Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132022AbQLMV7s>; Wed, 13 Dec 2000 16:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbQLMV7h>; Wed, 13 Dec 2000 16:59:37 -0500
Received: from [129.142.25.50] ([129.142.25.50]:46981 "HELO mail.storner.dk")
	by vger.kernel.org with SMTP id <S132022AbQLMV73>;
	Wed, 13 Dec 2000 16:59:29 -0500
To: linux-kernel@vger.kernel.org
Path: news.storner.dk!not-for-mail
From: henrik@storner.dk (Henrik Størner)
Newsgroups: linux.kernel
Subject: Re: test12: innd bug came back?
Date: 13 Dec 2000 22:29:01 +0100
Organization: Linux Users Inc.
Message-ID: <918pmt$q9s$1@osiris.storner.dk>
In-Reply-To: <20001213103630.263847.FMU323@casus.omskelecom.ru>
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <20001213103630.263847.FMU323@casus.omskelecom.ru> Anton Petrusevich <casus@omskelecom.ru> writes:

>Today I saw well-known "innd bug"(truncate(tm)), and my brother said
>he had seen it with -test12-pre7. I don't know about -test12-pre3,
>neither I nor my brother hadn't noticed it since -test10. But we could
>miss it with -test12-pre3, and I didn't try any -test11 kernels. Thus
>possibly that was introduced changes between -test12-pre3 and
>-test12-pre7, but I can definitly say it present in -test12-final.

Just to add a "me too" on this. I didn't report when I saw it last week,
because I was uncertain of exactly what might have caused it - I was
booting several different kernels at the time, including one from a
rescue disk (I was trying to salvage bits of a Win9x disk at the time -
don't ask for details!)

Alas, I lost the test program someone wrote to test for the truncate
problem, and due to moving I will not be able to test anything until 
next Monday. But if needed, I can do some testing then. Something 
definitely went wrong with innd during the test12 pre-patches.
-- 
Henrik Storner      | "Crackers thrive on code secrecy. Cockcroaches breed 
<henrik@storner.dk> |  in the dark. It's time to let the sunlight in."
                    |  
                    |          Eric S. Raymond, re. the Frontpage backdoor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
