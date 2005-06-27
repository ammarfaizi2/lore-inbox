Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVF0PCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVF0PCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVF0O4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:56:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:8672 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261844AbVF0NNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:13:50 -0400
Date: Mon, 27 Jun 2005 15:13:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, dtor@mail.ru
Subject: Re: 2.6.12-mm2
Message-ID: <20050627131347.GA9180@ucw.cz>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626101851.A18283@mail.kroptech.com> <20050626122538.34152dda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626122538.34152dda.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 12:25:38PM -0700, Andrew Morton wrote:

> > I'd like to lobby for the merging into mainline of this patch from
> > git-input. It fixes a real bug, seen by real users, and has been
> > languishing in the input tree since March. It may also be a candidate
> > for the stable tree given it's one-linedness.
> 
> I think we can merge all of git-input into Linus's tree immediately.

I've checked it, the patches I had originally problems with are already
fixed, it's ready for merging.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
