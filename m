Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWIUVvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWIUVvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWIUVvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:51:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7815
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751625AbWIUVvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:51:55 -0400
Date: Thu, 21 Sep 2006 14:52:08 -0700 (PDT)
Message-Id: <20060921.145208.26283973.davem@davemloft.net>
To: jeff@garzik.org
Cc: davidsen@tmr.com, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
From: David Miller <davem@davemloft.net>
In-Reply-To: <45130527.1000302@garzik.org>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<45130533.2010209@tmr.com>
	<45130527.1000302@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Thu, 21 Sep 2006 17:33:27 -0400

> Bill Davidsen wrote:
> > I think it would help if you went back to using meaningful names for 
> > releases, because 2.6.19-test1 is pretty clearly a test release even to 
> > people who can't figure out if a number is odd or even. Then after 
> > people stop reporting show stoppers, change to rc numbers, where rc 
> > versions are actually candidates for release without known major bugs.
> 
> Actually, considering our group of developers, I think "-rc" has been 
> remarkably successful at staying on the "bug fixes only" theme.

I agree.

But even on that note I would love to have a release cycle where I
didn't merge any new features and could work entirely on the bugs
that never get worked on.

Sure, I'll still be merging new features into my "N + 1" tree.
But my pure interactions with Linus's tree can focus entirely
on bug fixing, and I really want an environment in which to
concentrate on that exclusively.

I think the even/odd idea is great, personally.  And if this
makes some people have to wait a little bit longer for their
favorite feature to get merged, that's tough. :-)

I truly think we need to move towards a more stability minded
mode and back off on the new features just a bit.

