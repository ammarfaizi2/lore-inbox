Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272385AbTHNOrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272388AbTHNOri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:47:38 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61382 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S272385AbTHNOrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:47:37 -0400
Date: Thu, 14 Aug 2003 07:47:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: Eli Carter <eli.carter@inet.com>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030814144711.GA5926@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Eli Carter <eli.carter@inet.com>, Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, davej@redhat.com,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F3B9AF8.4060904@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3B9AF8.4060904@inet.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:21:44AM -0500, Eli Carter wrote:
> >That ought to be balanced with "don't screw up the revision history, people
> >use it".  It's one thing to reformat code that is unreadable, for the most
> >part this code didn't come close to unreadable.
> 
> Devil's advocate:
> Then perhaps the (revision control) tool is getting in the way of doing 
> the job and should be fixed?  :)
> Perhaps being able to flag a changeset as a 'formatting change', and 
> have the option to hide it or make it 'transparent' in some fashion? 
> Hmm... "Annotate only the changes that relate to feature X."...
> Oh, and a complete AI with that if you don't mind. ;)
> 
> But you've probably already thought about all this...

Indeed I have.  And there is a reason that we have a policy at BitMover
where "formatting changes" are prohibited and we make people redo their
changesets until they get them right.

In other words, you are welcome to write a revision control system
which can look through the formatting changes and give you the semantic
knowledge that you want.  We'd love to see how it is done and then do
it in BitKeeper :)
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
