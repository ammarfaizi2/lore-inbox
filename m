Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTE2Vvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTE2Vvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:51:40 -0400
Received: from 12-203-29-198.client.attbi.com ([12.203.29.198]:50870 "EHLO
	mystic.osdl.org") by vger.kernel.org with ESMTP id S262861AbTE2Vv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:51:26 -0400
From: Nathan <smurf@osdl.org>
Date: Thu, 29 May 2003 15:03:43 -0700
To: Andi Kleen <ak@suse.de>
Cc: Mark Peloquin <peloquin@austin.ibm.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: Nightly regression runs against current bk tree
Message-ID: <20030529220343.GL25252@osdl.org>
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel> <p73smqx791m.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73smqx791m.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 11:11:17PM +0200, Andi Kleen wrote:
> It would be nice if we had a new linux-testresults list where such
> updates could be posted regularly. I don't think it belong on l-k
> because it would be too noisy. Perhaps such a list could be added to 
> vger. David, what do you think?

The OSDL has a serious amount of automated testing we could point the
results of to a separate list if it is created.

Right now we avoid pointing that sort of thing to l-k because it would
drive people nuts.  On average we complete 40+ tests a day.

With all the testing efforts going on, a central list to post and
analyze results would be good.  People interested in helping out could
easily work with testers to look for trends and help with root cause
analysis.

When results are found to contain significant data, we can always notify l-k.

-Nathan Dabney
