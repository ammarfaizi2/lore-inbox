Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWIZU13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWIZU13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWIZU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:27:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:16342 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964787AbWIZU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:27:28 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: x86/x86-64 merge for 2.6.19
Date: Tue, 26 Sep 2006 22:26:09 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de> <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262226.09418.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 22:19, Linus Torvalds wrote:
> 
> On Tue, 26 Sep 2006, Andi Kleen wrote:
> > > 
> > > I really don't want do http:// pulls - they are very inefficient, and I 
> > > don't trust the end result because the http protocol isn't really good for 
> > > verifying the end result (same goes for rsync:// to an even bigger 
> > > degree). 
> > 
> > Sorry that was actually me typoing (my fingers are not used to git:// urls
> > yet) I've sent you a new email with correct URL
> 
> I actually tried it with "git://" instead of "http://" bit maybe I typoed 
> too.

Yes I managed to typo twice  (linus-2.6 instead of linux-2.6)
Amazing, wasn't it?
 
> Anyway, the new address was fine. Pulled, pushed out.

Thanks.
 
> (Side note, I'm hoping we can sync up more easily now, and in smaller 
> chunks ;)

Yes that is why I did it. I still use quilt for my tree because it works
best for me, but together with all the i386 stuff I was over 230 patches
and email clearly didn't scale well to that much.

-Andi

