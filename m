Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275515AbTHNUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275516AbTHNUQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:16:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:1241 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S275515AbTHNUQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:16:23 -0400
Date: Thu, 14 Aug 2003 13:16:05 -0700
From: Larry McVoy <lm@bitmover.com>
To: dri-devel@lists.sourceforge.net, Eli Carter <eli.carter@inet.com>,
       Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030814201605.GA16291@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	dri-devel@lists.sourceforge.net, Eli Carter <eli.carter@inet.com>,
	Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F3B9AF8.4060904@inet.com> <20030814144711.GA5926@work.bitmover.com> <20030814114340.A48492@bolthole.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030814114340.A48492@bolthole.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 11:43:40AM -0700, Philip Brown wrote:
> On Thu, Aug 14, 2003 at 07:47:11AM -0700, Larry McVoy wrote:
> > ...
> > Indeed I have.  And there is a reason that we have a policy at BitMover
> > where "formatting changes" are prohibited and we make people redo their
> > changesets until they get them right.
> > 
> > In other words, you are welcome to write a revision control system
> > which can look through the formatting changes and give you the semantic
> > knowledge that you want.  We'd love to see how it is done and then do
> > it in BitKeeper :)
> 
> You should allow for ...

Didn't you mean "in the SCM system I'm writing, I allow for ..."?

Besides, your point is content specific.  People check things other than
C code into BK.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
