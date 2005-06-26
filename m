Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVFZToD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFZToD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFZTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:42:07 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59071 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261603AbVFZTja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:39:30 -0400
Date: Sun, 26 Jun 2005 21:39:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, dtor@mail.ru
Subject: Re: 2.6.12-mm2
Message-ID: <20050626193943.GA2120@ucw.cz>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626101851.A18283@mail.kroptech.com> <20050626122538.34152dda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626122538.34152dda.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 12:25:38PM -0700, Andrew Morton wrote:

> Adam Kropelin <akropel1@rochester.rr.com> wrote:
> >
> > I'd like to lobby for the merging into mainline of this patch from
> > git-input. It fixes a real bug, seen by real users, and has been
> > languishing in the input tree since March. It may also be a candidate
> > for the stable tree given it's one-linedness.
> > 
> 
> I think we can merge all of git-input into Linus's tree immediately.
> 
> But if that'll take some time then sure, we can merge up this little bit.

I have some minor issues with a few of the patches. I'll take care of
that tomorrow, and then it can be merged to Linus.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
