Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTI2Wjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTI2Wjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:39:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62993 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262994AbTI2Wjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:39:43 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Can't X be elemenated?
Date: 29 Sep 2003 22:30:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blabpn$4fp$1@gatekeeper.tmr.com>
References: <LAW11-F18b4SaFMwr9y00007564@hotmail.com>
X-Trace: gatekeeper.tmr.com 1064874615 4601 192.168.12.62 (29 Sep 2003 22:30:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <LAW11-F18b4SaFMwr9y00007564@hotmail.com>,
kartikey bhatt <kartik_me@hotmail.com> wrote:
| Hi Linus.
| 
| I read your reply to a person worried about the future of linux. It was a
| satisfactory reply; I hope to get a satisfactory reply for this one also.
| 
| Can't X be elemenated?
| 
| I mean to say kernel level support for graphics device drivers and special
| routines for accessing it directly; rest will be done by user space widget
| libraries (or say a kernel space light widget library which can be 
| customized
| by user space libraries).
| 
| Why am I asking this?
| 
| 1st. X is bloat. Though it's good for server environments. For desktop pcs
| it's too heavy. On my machine (PIII500 with 128MB RAM) I have to choose from
| either to run X or compile 2.6.0-test6.

So you have the config wrong... I compile a kernel while reading mail
with Kmail, which I use so I can follow links which my text mailer
ignores (and thereby avoids any eveil content). I use a PII-350 with
96MB for my 2.6 test box, and it frequently is also running real work as
well.

Did you forget to enable swap or something?
| 
| 2nd. It's process based client/server architecture is a bottleneck. It's not
| as interactive as is supposed to be.

That's silly, servers don't need X, in many cases they don't even have a
console device.
| 
| 3rd. Most important. I can't impress or convince my window(crash)(TM) user
| friends, relatives (who saw X running on my pc) to use Linux.

And you don't give good demos, either. If you want to impress Windows
users, try the "uptime" command.
| 
| 4th. I want to see desktop being ruled by Linux.

Doing without X isn't the answer. And except on some embedded
application, the cost of memory is so low there just isn't any reason to
worry about it, it's only an issue on really old boxen, and those are
will served by just using a console, not by trying to save a few bytes
by eviscerating the kernel.
| 
| "Present" is in our hands; we are ruling servers.
| You said "Linux, world domination fast".
| If my wish is fulfilled, I am sure, one day, You (Mr. Linus) and I will
| be saying "Linux, world domination completed".
| 
| 
| 		-Kartikey Mahendra Bhatt.
| 
| (Sorry for raising this question during feature freeze. But the
| consequences in last few days have forced me to ask this question.)
| 
| _________________________________________________________________
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
