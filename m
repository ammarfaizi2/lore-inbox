Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284788AbRLPUln>; Sun, 16 Dec 2001 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284814AbRLPUle>; Sun, 16 Dec 2001 15:41:34 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:62158 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S284788AbRLPUlT>; Sun, 16 Dec 2001 15:41:19 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200112162041.fBGKfG202399@ns.home.local>
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
To: vdb@mail.ru
Date: Sun, 16 Dec 2001 21:41:16 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry !
> Below is simple test case which I think is related to "memory disappear"
> problem.
--snip--
> The results are very consistent. I lose 30-40 byte per run.

Nearly the same here on 2.4.10-ac12, but I loose only 4-8 kB each time.
So I think this is not related to the new VM, and perhaps it's a very
old thing.

Regards,
Willy

