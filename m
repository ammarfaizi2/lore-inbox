Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271381AbTHHP7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271415AbTHHP7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:59:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10368 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271381AbTHHP7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:59:50 -0400
Date: Fri, 8 Aug 2003 12:00:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jasper Spaans <jasper@vs19.net>
cc: Timothy Miller <miller@techsource.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
In-Reply-To: <20030808155044.GA12526@spaans.vs19.net>
Message-ID: <Pine.LNX.4.53.0308081156270.881@chaos>
References: <20030807180032.GA16957@spaans.vs19.net>
 <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com>
 <20030808065230.GA5996@spaans.vs19.net> <3F33BF33.8070601@techsource.com>
 <Pine.LNX.4.53.0308081127160.502@chaos> <20030808155044.GA12526@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Jasper Spaans wrote:

> > > > $ egrep -ni 'flavou?r' fs/nfs/inode.c
> > > > 1357:	rpc_authflavor_t authflavour;
>
> > However, changing the spelling of a variable name is
> > absurd no matter how you look at it.
>
> Read that line of code again please. Next, imagine writing code in there.
>
> VrGr,

Yes. It's wonderful. Pure poetry to me! It's probably in line
for the Pulitzer prize for literature. I like it.

That said, there probably is a good reason why not to define
a special type for that variable. But, then again, that's not
a spelling matter.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

