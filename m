Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267818AbTAME2V>; Sun, 12 Jan 2003 23:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267816AbTAME2U>; Sun, 12 Jan 2003 23:28:20 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:50009 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S267814AbTAME2U>; Sun, 12 Jan 2003 23:28:20 -0500
Message-Id: <5.2.0.9.0.20030112222851.00b28a20@pop.sbcglobal.yahoo.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sun, 12 Jan 2003 22:37:01 -0600
To: Adam Kropelin <akropel1@rochester.rr.com>
From: Billy Rose <passive_induction@sbcglobal.net>
Subject: Re: any chance of 2.6.0-test*?
Cc: Rob Wilkens <robw@optonline.net>, Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030112215949.GA2392@www.kroptech.com>
References: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:59 PM 1/12/2003 -0500, Adam Kropelin wrote:
>The use of goto in the kernel surprised me the first time I saw it, too.
>However, rather than hurry to point out how much more I knew about C
>style than the kernel hackers, I stayed quiet and made a learning
>experience of it. I suggest you do the same.
>
>--Adam

every article i have read (an agreed with) on operating system internals,
has stated that the goto is considered taboo in C... _except_ in operating
system code where speed is critical, and goto can increase readability.
i taught myself how to program by single stepping through assembly
code on a DOS machine. i have found that too much structure leads
not to modular code that is easy to maintain, but a nightmare of
conditionals that cause your head to throb trying to trace the state
of an execution. being that i am partial to assembly, perhaps i am
biased in the matter.

br 


