Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269047AbTCAWSk>; Sat, 1 Mar 2003 17:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269049AbTCAWSj>; Sat, 1 Mar 2003 17:18:39 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:13804 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id <S269047AbTCAWSj>;
	Sat, 1 Mar 2003 17:18:39 -0500
Date: Sat, 1 Mar 2003 23:29:10 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Update to 2.5.x snapshots
Message-ID: <20030301222910.GA3983@finwe.eu.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3E60FAAB.1080007@pobox.com> <20030301211611.GA23874@finwe.eu.org> <3E612A27.2050200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E612A27.2050200@pobox.com>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> >>Old 2.5.x BK snapshots on kernel.org are now moved into the "old" 
> >>sub-directory, instead of being deleted.
[...]
> >It may not be related, but  
> >http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/
> >has "BitKeeper patches since v2.4.21-pre4: 354 Changesets"
> >(not latest -pre).
> Yep, I know :)
> The point of nightly snapshots is more for users use and testing 
> purposes.  The csets are very useful for developers, but a bit of a 
> moving target for users.

I'm just used to look there from time to time to see 'what is new', and
AFAIR changes were reported against latest prerelease. 
>From my point of view, as long as patches are in chronological order 
it's not a problem. :)

> If users are using the per-cset snapshots, 
> then it becomes a non-trivial chore to developers to track down exactly 
> what version of the kernel a problem is reported against.

Csets are useful for users- e.g. if the problem you want to report does 
not exist in latest cset -but generaly you are right. 

	Jacek

