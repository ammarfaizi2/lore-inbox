Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267247AbUBSAfr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUBSAfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:35:47 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:20429 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267247AbUBSAfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:35:39 -0500
Message-ID: <403402DE.4030400@cyberone.com.au>
Date: Thu, 19 Feb 2004 11:27:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: Brice Figureau <brice+lklm@daysofwonder.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: spurious temporary freeze, scheduler and preempt problem
 ?
References: <1077117976.2265.61.camel@localhost.localdomain> <200402181212.06279.eric@cisu.net>
In-Reply-To: <200402181212.06279.eric@cisu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric wrote:

>On Wednesday 18 February 2004 9:26 am, Brice Figureau wrote:
>Someone correct me if I'm way off base, but have you tried
>	scheduler=deadline
>To try the different kernel schedulers?
>Im not sure about the keyword, but do a quick google or search lkml and you'll 
>see the correct keyword and the different schedulers you can try.
>
>
>

It's probably a CPU scheduler related problem, so this
wouldn't do much.

