Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275221AbTHMO71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275226AbTHMO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:59:27 -0400
Received: from rzaixsrv2.rrz.uni-hamburg.de ([134.100.32.71]:17625 "EHLO
	rzaixsrv2.rrz.uni-hamburg.de") by vger.kernel.org with ESMTP
	id S275221AbTHMO7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:59:25 -0400
Message-ID: <1060786763.3f3a524bd59f1@rzaixsrv6.rrz.uni-hamburg.de>
Date: Wed, 13 Aug 2003 16:59:23 +0200
From: in7y118@public.uni-hamburg.de
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6 doesn't like Rhythmbox
References: <1060699703.3f38fe37b8a1f@rzaixsrv6.rrz.uni-hamburg.de> <1060704354.856.1.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1060704354.856.1.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>:

> Don't blame anyone still... There's still ongoing kernel scheduler work.
> Please, try the latest -mm patches on top of 2.6.0-test3. You will find
> them at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches.
> 
> Experiment with 2.6.0-test3-mm1 to see if it still shows the behaviour
> you described.
> 
I tried it. -test3-mm1 works perfectly fine with Rhythmbox. X was a bit slow to 
update sometimes under heavy load, but I guess that's known.
Stock -test3 showed the same bda behaviour as -test2 though.

The only thing I don't want is users telling me my apps suck. So I thought 
alerting would be better than waiting for distributions to ship those kernels.


Thanks
Benjamin
