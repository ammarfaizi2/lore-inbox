Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTCaIoR>; Mon, 31 Mar 2003 03:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTCaIoR>; Mon, 31 Mar 2003 03:44:17 -0500
Received: from dial-ctb0158.webone.com.au ([210.9.241.58]:29711 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261485AbTCaIoQ>;
	Mon, 31 Mar 2003 03:44:16 -0500
Message-ID: <3E88024D.5000604@cyberone.com.au>
Date: Mon, 31 Mar 2003 18:54:37 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Jens Axboe <axboe@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
References: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net> <20030330141404.GG917@suse.de> <3E8610EA.8080309@telia.com> <1048992365.13757.23.camel@localhost> <20030330141404.GG917@suse.de> <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net> <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 08:35 AM 3/31/2003 +0200, Jens Axboe wrote:
>
>> What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
>> ever used, it would be _embarassing_ to release a 2.6-test with such a
>> rudimentary flaw in it. IOW, a big show stopper.
>
>
> It's only horrible when you trigger the problems, otherwise it's 
> wonderful. 

Heh heh, yeah the anticipatory io scheduler is like that too ;)

