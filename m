Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbTCMAMT>; Wed, 12 Mar 2003 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbTCMAMS>; Wed, 12 Mar 2003 19:12:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34322 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261363AbTCMAMS>; Wed, 12 Mar 2003 19:12:18 -0500
Message-ID: <3E6FCF54.60708@zytor.com>
Date: Wed, 12 Mar 2003 16:22:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Roman Zippel <zippel@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com> <Pine.LNX.4.44.0303080116500.32518-100000@serv> <3E693D65.8060308@zytor.com> <Pine.LNX.4.44.0303080208340.32518-100000@serv> <20030312172706.GA5489@zaurus.ucw.cz>
In-Reply-To: <20030312172706.GA5489@zaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> I believe HPA wants klibc to stay small,
> and BSD license will act as contribution-
> stopper, therefore keeping it small...
> 

Heh,

Although that may be a beneficial side effect :) the real reason is the
one Linus articulated:

> I can _totally_ see hpa's point that he would be perfectly happy with
> people "stealing" parts of it - the code in question is not something
> that anybody should _ever_ have to re-create, even if he's the most
> evil person on earth and hates the GPL and wants to kill us all.
> Because it's not _worth_ recreating.

	-hpa

