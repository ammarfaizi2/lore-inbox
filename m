Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281140AbRKOWhA>; Thu, 15 Nov 2001 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281139AbRKOWgu>; Thu, 15 Nov 2001 17:36:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:35845 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281132AbRKOWgh>;
	Thu, 15 Nov 2001 17:36:37 -0500
Subject: Re: kswapd using a lot of CPU
From: Robert Love <rml@tech9.net>
To: Steffen Persvold <sp@scali.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF44234.FFC3BE9@scali.no>
In-Reply-To: <3BF44234.FFC3BE9@scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 15 Nov 2001 17:36:53 -0500
Message-Id: <1005863814.870.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-15 at 17:31, Steffen Persvold wrote:
> What the f**k is going on here (RedHat 7.1 kernel-2.4.9-12smp, glibc-2.2.4-19)
> ?
>
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>     5 root      20   0     0    0     0 RW   78.4  0.0  97:45 kswapd

Upgrade to a newer kernel, 2.4.10 and onward should solve this problem. 
The newest kernel is 2.4.14 -- just go for that.

	Robert Love

