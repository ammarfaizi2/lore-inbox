Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbTCJGvi>; Mon, 10 Mar 2003 01:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbTCJGvi>; Mon, 10 Mar 2003 01:51:38 -0500
Received: from tag.witbe.net ([81.88.96.48]:52740 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262100AbTCJGvh>;
	Mon, 10 Mar 2003 01:51:37 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Rusty Lynch'" <rusty@linux.co.intel.com>
Cc: "'Paul Larson'" <plars@linuxtestproject.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Available watchdog test cases
Date: Mon, 10 Mar 2003 08:02:16 +0100
Message-ID: <002601c2e6d2$fc7aebb0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <1047273790.6399.13.camel@vmhack>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I know people are all trying to avoid Oops... but I think 
> the testplan 
> > should include that too...
> 
> You can write a kernel module that when loaded will disable 
> all interrupts and sit and spin, or even easier just call panic().
> 
Too easy I should have thought about it myself...

Thanks for the tip...

Regards,
Paul

