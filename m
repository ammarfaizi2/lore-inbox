Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270319AbTHGQQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270324AbTHGQQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:16:10 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:3289 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S270319AbTHGQPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:15:52 -0400
Date: Thu, 7 Aug 2003 12:15:45 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] bkbits annotated srcs
In-Reply-To: <20030807134511.GA1089@work.bitmover.com>
Message-ID: <Pine.LNX.4.56.0308071211080.8699@filesrv1.baby-dragons.com>
References: <20030807102214.06223100.jani@iv.ro> <20030807134511.GA1089@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Larry ,  Could we please put a 'annotated' button at
	http://linux.bkbits.net:8080/linux-2.5/ &
	http://linux.bkbits.net:8080/linux-2.4/
	in the search function ?

	Doing a search for sym53c8xx_2 in ChangeSet comments get me
	output that is a little bit odd to read ( see below) .
	ie: Note the lack of formatting after the Rev position .  Not all
	entries are like this but if the Rev string is long they all are .

ChangeSet        1.1046.398.19[PATCH] make sym53c8xx_2 not reject autosense IWR
ChangeSet        1.1046.398.19This patch makes sym53c8xx_2 silently ignore the Ignore Wide Residue
ChangeSet        1.1046.398.16[PATCH] small patch for sym53c8xx_2
ChangeSet        1.1046.398.16dma64_addr_t in the sym53c8xx_2 driver was wrong, but it's still
...

	Tia ,  JimL


On Thu, 7 Aug 2003, Larry McVoy wrote:
> On Thu, Aug 07, 2003 at 10:22:14AM +0300, Jani Monoses wrote:
> > Is there a way of seeing annotated sources of the kernel via the web
> > interface? I see it's possible for changesets and I know it's possible
> > with bk installed.
>
> To get the annotated listing of the most recent version of any file use
> this URL, changing the filename as appropriate:
>
> 	http://linux.bkbits.net:8080/linux-2.5/anno/README@+
>
> Note that the "@" may change to a "|" in the future.
>

-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
