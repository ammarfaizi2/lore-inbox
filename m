Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSAIQZq>; Wed, 9 Jan 2002 11:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAIQZh>; Wed, 9 Jan 2002 11:25:37 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:26129 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287804AbSAIQZ2>; Wed, 9 Jan 2002 11:25:28 -0500
Date: Wed, 9 Jan 2002 19:25:26 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for reiserfs
Message-ID: <20020109192526.A1732@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny> <20020109185826.A1680@namesys.com> <100150000.1010592449@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <100150000.1010592449@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 09, 2002 at 11:07:29AM -0500, Chris Mason wrote:

> >> This should not be applied until an updated (non beta) reiserfsprogs
> >> package that supports these features has been released.
> > Hey, reserving some space in superblock won't hurt.
> Reserving it is fine ;-)  Using it isn't a good idea until the progs
So we did it (reserved) ;)
We do not use it. (generating of UUID does not count)

> understand it.  Our policy should be to never require a progs update in a
> stable kernel series (just like most stable parts of the kernel).
We do not require progs upadte. But if someone will update their progs voluntarily,
we cannot forbit them to! ;))

> Neither should this patch (even though it is a much smaller problem).
You just said that reserving is ok.

Bye,
    Oleg
