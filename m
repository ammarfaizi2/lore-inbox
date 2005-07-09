Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVGIXat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVGIXat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 19:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVGIXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 19:30:49 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:42142 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261770AbVGIXaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 19:30:46 -0400
Message-ID: <19474.71.111.147.75.1120951847.squirrel@chretien.affordablehost.com>
In-Reply-To: <1120944358.6488.90.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> 
    <20050708214908.GA31225@taniwha.stupidest.org> 
    <20050708145953.0b2d8030.akpm@osdl.org> 
    <1120928891.17184.10.camel@lycan.lan>
    <1120932991.6488.64.camel@mindpipe> 
    <1120933916.3176.57.camel@laptopd505.fenrus.org> 
    <1120934163.6488.72.camel@mindpipe>
    <20050709121212.7539a048.akpm@osdl.org> 
    <1120936561.6488.84.camel@mindpipe> 
    <20050709133036.11e60a3c.rdunlap@xenotime.net>
    <1120944358.6488.90.camel@mindpipe>
Date: Sat, 9 Jul 2005 16:30:47 -0700 (PDT)
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "randy_dunlap" <rdunlap@xenotime.net>, akpm@osdl.org, arjan@infradead.org,
       azarah@nosferatu.za.org, cw@f00f.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, christoph@lameter.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell said:
> On Sat, 2005-07-09 at 13:30 -0700, randy_dunlap wrote:
>> | Then the owners of such machines can use HZ=250 and leave the default
>> | alone.  Why should everyone have to bear the cost?
>>
>> indeed, why should everyone have to have 1000 timer interrupts per
>> second?
>
> So why waste everyone's time with CONFIG_HZ when there are working
> dynamic tick solutions out there?  It's just bad release engineering.

hey, that seems to expect some top-level release (or project)
management.  ;)

anyway, I was just trying to point out more than one side to this,
and you have now done the same.  thanks.

-- 
~Randy

