Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbRETBLk>; Sat, 19 May 2001 21:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261252AbRETBLb>; Sat, 19 May 2001 21:11:31 -0400
Received: from mail.ntplx.net ([204.213.176.10]:24456 "EHLO mail.ntplx.net")
	by vger.kernel.org with ESMTP id <S261251AbRETBLV>;
	Sat, 19 May 2001 21:11:21 -0400
Message-ID: <3B0718AB.7E2FF3A2@ntplx.net>
Date: Sat, 19 May 2001 21:06:51 -0400
From: Benedict Bridgwater <bennyb@ntplx.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brown-paper-bag bug in m68k, sparc, and sparc64 config files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This bug unconditionally disables a configuration question -- and it's
> so old that it has propagated across three port files, without either
> of the people who did the cut and paste for the latter two noticing it.
>
> This sort of thing would never ship in CML2, because the compiler
> would throw an undefined-symbol warning on BLK_DEV_ST.  The temptation
> to engage in sarcastic commentary at the expense of people who still
> think CML2 is an unnecessary pain in the butt is great.  But I will
> restrain myself.  This time.

So a shortcoming of the CML1 tools justifies the CML2 language?

I guess the next bug found in the Python2 interpreter will justify
writing CML3 in FORTRAN.

Ben
