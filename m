Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766630AbWJUSPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766630AbWJUSPn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766619AbWJUSPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:15:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:23466 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S637743AbWJUSPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:15:00 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Please pull x86 tree
Date: Sat, 21 Oct 2006 20:14:48 +0200
User-Agent: KMail/1.9.5
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200610211844.07051.ak@suse.de> <20061021175121.GF5211@rhun.haifa.ibm.com>
In-Reply-To: <20061021175121.GF5211@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610212014.48914.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 19:51, Muli Ben-Yehuda wrote:
> On Sat, Oct 21, 2006 at 06:44:06PM +0200, Andi Kleen wrote:
> > 
> > Linus, please pull from
> > 
> >   git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus
> > 
> > These are all accumulated bug fixes for x86-64 and i386 and should
> > be all pretty safe.
> > 
> > The only thing that isn't a clear bug fix is the dwarf2 unwinder
> > speedup -- i'm including that on popular demand because it fixes
> > a serious performance regression with lockdep.
> 
> It would've been good to get the Calgary bug-fix in this
> series... next one, please?

You said it wasn't critical and I only sent critical issues

-Andi
