Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUJ0FYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUJ0FYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 01:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUJ0FYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 01:24:06 -0400
Received: from holomorphy.com ([207.189.100.168]:58603 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261647AbUJ0FYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 01:24:03 -0400
Date: Tue, 26 Oct 2004 22:23:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Rik van Riel <riel@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041027052321.GT15367@holomorphy.com>
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com> <20041027051342.GK19761@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027051342.GK19761@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:29:10AM -0400, Rik van Riel wrote:
>> While a 2.7 series might provide developers with an "outlet"
>> for their creativity, it does not give users the availability
>> of the features they need.

On Wed, Oct 27, 2004 at 07:13:42AM +0200, Willy Tarreau wrote:
> Rik, "new features" are what causes the kernel to be in permanent development
> mode. It happened to all of us that a new feature broke compatability with a
> patch or even caused a side effect. Users don't "need" new features, they
> *want* them. This is what makes them upgrade to the new release in a fast
> release model. If 2.4 had been released sooner, USB would never have made
> it in 2.2, and 2.2 users would have switched faster. I know people who still
> use 2.2 only on their dev systems because they don't need any upgrade.

The new features you're complaining about are astoundingly not the
causes of any of the bugs cited as critical issues in this thread.

It also appears that you have forgotten early 2.4 at the very least...


-- wli
