Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269909AbRHMKtG>; Mon, 13 Aug 2001 06:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRHMKs5>; Mon, 13 Aug 2001 06:48:57 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18963 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269909AbRHMKsv>; Mon, 13 Aug 2001 06:48:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: VM working much better in 2.4.8 than before
Date: Mon, 13 Aug 2001 12:55:12 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20010811234822.A422@debian> <3B7792B9.61721B85@idb.hist.no>
In-Reply-To: <3B7792B9.61721B85@idb.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010813104900Z16329-1231+665@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 10:41, Helge Hafting wrote:
> misty-@charter.net wrote:
> > 
> >         I've said it before, I'll say it again - you guys deserve a
> > 'this is a great thing' report once in a while. This is such a report :)
> 
> 2.4.8 is good indeed.  My vmstat window tells me it ties up
> about 40M less in page cache than earlier kernels, possibly an
> effect of use-once.  (This is a 128M desktop machine.)
> 
> updatedb run still manages to use some swap, but the machine
> is no longer sluggish in the morning. :-)

Yes, those would be the expected effects of use-once, in fact it was
"morning after updatedb" question that got me started on it.

BTW, keep that 486, it's a great reality check!

--
Daniel
