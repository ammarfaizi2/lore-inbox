Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTBYBlQ>; Mon, 24 Feb 2003 20:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbTBYBlQ>; Mon, 24 Feb 2003 20:41:16 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265457AbTBYBlJ>;
	Mon, 24 Feb 2003 20:41:09 -0500
Subject: Re: Minutes from Feb 21 LSE Call - publishing performance data
From: Craig Thomas <craiger@osdl.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: yodaiken@fsmlabs.com, Benjamin LaHaise <bcrl@redhat.com>,
       Larry McVoy <lm@work.bitmover.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E18nNDR-00035B-00@w-gerrit2>
References: <E18nNDR-00035B-00@w-gerrit2>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1046137860.11776.381.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Feb 2003 17:51:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 10:20, Gerrit Huizenga wrote:

> 
> We do have a few papers out there, check OLS for the large database
> workload one that steps through 2.4 performance changes (stock
> 2.4 vs. a set of patches we pushed to UL & RHAT) that increase
> database performance about, oh, I forget, 5-fold...  And there
> is occasional other data sent out on web server stuff, some
> microbenchmark data (see the continuing stream of data from mbligh,
> for instance).  Also, the contest data, OSDL data, etc. etc.
> shows comparisons and trends for anyone who cares to pay attention.
> 
> It *would* be nice if someone could publish a compedium of performance
> data, but that would be asking a lot...
> 
> gerrit
> -

OSDL is trying to provide something like this for the 2.5 kernel.  It is
an interest we have to provide this sort of data. We have been building
database workload information and generating test results from our STP
test framework.

We are in the midst of creating content for a Linux Stability Results
web page.  http://www.osdl.org/projects/26lnxstblztn/results/  There is
a great desire on our part to share good performance data for the kernel
as it evolves.  I would like to ask you guys what would you like to
see on page like this?  I feel that we could create a single site where
anyone can get access to performance and reliability information about
the Linux kernel as we move toward the 2.6 version.

The page is set up now so that anyone can contribute content to the page
by editing an html template file to point to test and performance data.
If anyone is interested in this concept, email me privately or
cliffw@osdl.org


-- 
Craig Thomas <craiger@osdl.org>
OSDL

