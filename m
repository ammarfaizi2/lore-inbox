Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUAEEOr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbUAEEOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:14:47 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:30357
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265897AbUAEEOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:14:46 -0500
Message-ID: <3FF8E4C8.1070604@tmr.com>
Date: Sun, 04 Jan 2004 23:15:04 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org> <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl> <3FF7A910.40703@tmr.com> <Pine.LNX.4.58.0401041232440.2162@home.osdl.org> <3FF8BDBB.4060708@tmr.com> <Pine.LNX.4.58.0401041824150.2162@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401041824150.2162@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 4 Jan 2004, Bill Davidsen wrote:
> 
>>You pointed out that this generates good code, I pointed out that it 
>>also avoids future errors and is not just a trick for broken compilers. 
>>I take your point about generating good code, I'm sorry you can't see 
>>that avoiding code duplication is good practice even without the benefit 
>>of better code.
> 
> 
> Don't be silly. Using non-standard C is _never_ good practice.

Your example, which I quoted, *is* standard C. And it avoids duplication 
of code without extra variables, and is readable. We both agreed it was 
standard, why have you canged your mind?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
