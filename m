Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbSLSTmE>; Thu, 19 Dec 2002 14:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbSLSTmE>; Thu, 19 Dec 2002 14:42:04 -0500
Received: from zeke.inet.com ([199.171.211.198]:29349 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266038AbSLSTmD>;
	Thu, 19 Dec 2002 14:42:03 -0500
Message-ID: <3E0222E4.5070104@inet.com>
Date: Thu, 19 Dec 2002 13:49:56 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, lm@bitmover.com, lm@work.bitmover.com,
       torvalds@transmeta.com, vonbrand@inf.utfsm.cl, akpm@digeo.com
Subject: Re: Dedicated kernel bug database
References: <200212191335.gBJDZRDL000704@darkstar.example.net> <3E020660.9020507@inet.com> <20021219184958.GA6837@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Dec 19, 2002 at 11:48:16AM -0600, Eli Carter wrote:
[snip]
>  > >It could warn the user if they attach an un-decoded oops that their
>  > >bug report isn't as useful as it could be, and if they mention a
>  > >distribution kernel version, that it's not a tree that the developers
>  > >will necessarily be familiar with
>  > Perhaps a more generalized hook into bugzilla for 'validating' a bug 
>  > report, then code specific validators for kernel work?
> 
> Its a nice idea, but I think it's a lot of effort to get it right,
> when a human can look at the dump, realise its not decoded, and
> send a request back in hardly any time at all.
> I also don't trust things like this where if something goes wrong,
> we could lose the bug report. People are also more likely to ping-pong
> ,argue or "how do I..." with a human than they are with an automated robot.

Either way, it isn't kernel specific.... which is what I was trying to 
address.  If it is valuable (which as you demonstrate is debatable,) 
then it is valuable in bugzilla baseline, not just kernel-bugzilla.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

