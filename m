Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290770AbSBFTgE>; Wed, 6 Feb 2002 14:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSBFTfy>; Wed, 6 Feb 2002 14:35:54 -0500
Received: from ns.caldera.de ([212.34.180.1]:31380 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290753AbSBFTfs>;
	Wed, 6 Feb 2002 14:35:48 -0500
Date: Wed, 6 Feb 2002 20:35:21 +0100
Message-Id: <200202061935.g16JZLh18377@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: lm@bitmover.com (Larry McVoy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020206000343.I14622@work.bitmover.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020206000343.I14622@work.bitmover.com> you wrote:
>> I second that. Maybe however we can have it both ways -- I have no
>> experience with bk, but can't this same info be made available elsewhere
>> like a public web interface or some such thing?
>
> I've put up read-only clones on 
>
> 	http://linux.bkbits.net
>
> you can go there and get the changelogs in web form.  I just figured out
> what a bad choice 8088 was for a port and we'll be moving stuff over to
> 8080 since that seems to go through more firewalls.

Btw, is there a generic way to move repos cloned from Ted's (now
orphaned?) 2.4 tree to Linus' official one?

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
