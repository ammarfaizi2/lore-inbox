Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbTCKEZC>; Mon, 10 Mar 2003 23:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCKEZC>; Mon, 10 Mar 2003 23:25:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262815AbTCKEZB>;
	Mon, 10 Mar 2003 23:25:01 -0500
Message-ID: <33030.4.64.238.61.1047357343.squirrel@www.osdl.org>
Date: Mon, 10 Mar 2003 20:35:43 -0800 (PST)
Subject: Re: Available watchdog test cases
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rol@as2917.net>
In-Reply-To: <002601c2e6d2$fc7aebb0$3f00a8c0@witbe>
References: <1047273790.6399.13.camel@vmhack>
        <002601c2e6d2$fc7aebb0$3f00a8c0@witbe>
X-Priority: 3
Importance: Normal
Cc: <rusty@linux.co.intel.com>, <plars@linuxtestproject.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
>> > I know people are all trying to avoid Oops... but I think
>> the testplan
>> > should include that too...
>>
>> You can write a kernel module that when loaded will disable
>> all interrupts and sit and spin, or even easier just call panic().
>>
> Too easy I should have thought about it myself...

Steve Hemminger of OSDL did one of these.  You can get it at
  www.osdl.org/archive/rddunlap/tools/dump_test.c
if you are interested.  (I just put it there and there is a
15-minute rsync delay...)

~Randy



