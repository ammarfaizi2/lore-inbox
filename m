Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVIEICH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVIEICH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVIEICH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:02:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31506 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932288AbVIEICF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:02:05 -0400
Date: Mon, 5 Sep 2005 10:01:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Sander <sander@humilis.net>
Cc: Willy Tarreau <willy@w.ods.org>, Sean <seanlkml@sympatico.ca>,
       Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905080153.GA17081@alpha.home.local>
References: <35547.10.10.10.10.1125892279.squirrel@linux1> <20050905040311.29623.qmail@web50204.mail.yahoo.com> <50570.10.10.10.10.1125893576.squirrel@linux1> <20050905043613.GD30279@alpha.home.local> <20050905064135.GB27746@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905064135.GB27746@favonius>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 08:41:36AM +0200, Sander wrote:
> Willy Tarreau wrote (ao):
> > So you're both half-right from your point of view. But you're both half-wrong
> > too : no, people can't always choose, and no, people who don't choose their
> > laptop are not impacted by development kernels. So let's turn the page and
> > wait for a stable kernel.
> 
> If the company provides a laptop that doesn't mean that the user can't
> choose anymore. He can buy his own laptop. Companies don't allow you to
> fiddle with the installed OS anyway.

On what planet do you live ? When you're a "consultant" (I hate this word),
you take the laptop you're assigned, and use it at customers'. And when
you're fed up with windows (ie: after about 2 hours of work with its shitty
hyperterminal and telnet client), you take any Linux CD and scratch the
install to be able to work for what you're paid, whatever the guy who
installed windows thinks about it. And when he complains to the staff,
you tell them to call the customer to be aware of the time they made you
lose with their inappropriate tools.  If my laptop cannot run a decent
telnet client, tftp server, tcpdump, hping, ssh client/server, terminal
emulator, a very fast tcp/ip stack which by the way supports adding and
removing thousands of IP addresses without rebooting, then let it die.
And as I said, I am one of the lucky enough to be able to choose. That's
not the case for most of my coworkers.

Regards,
Willy

