Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423380AbWJUTl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423380AbWJUTl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423381AbWJUTl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:41:27 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:14093 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423380AbWJUTl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:41:26 -0400
Date: Sat, 21 Oct 2006 21:41:20 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Please pull x86 tree
Message-ID: <20061021194120.GG5211@rhun.haifa.ibm.com>
References: <200610211844.07051.ak@suse.de> <20061021175121.GF5211@rhun.haifa.ibm.com> <200610212014.48914.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610212014.48914.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 08:14:48PM +0200, Andi Kleen wrote:
> On Saturday 21 October 2006 19:51, Muli Ben-Yehuda wrote:
> > On Sat, Oct 21, 2006 at 06:44:06PM +0200, Andi Kleen wrote:
> > > 
> > > Linus, please pull from
> > > 
> > >   git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus
> > > 
> > > These are all accumulated bug fixes for x86-64 and i386 and should
> > > be all pretty safe.
> > > 
> > > The only thing that isn't a clear bug fix is the dwarf2 unwinder
> > > speedup -- i'm including that on popular demand because it fixes
> > > a serious performance regression with lockdep.
> > 
> > It would've been good to get the Calgary bug-fix in this
> > series... next one, please?
> 
> You said it wasn't critical and I only sent critical issues

You asked if it should go into 2.6.19 and I said it should. I also
said it's not critical, by which I meant "it doesn't need to go in
*right now*, it can wait for the next regularly-scheduled
patchset". Sorry about the confusion.

Thanks,
Muli
