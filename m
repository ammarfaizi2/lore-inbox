Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUJFJok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUJFJok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269170AbUJFJok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:44:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:25782 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269165AbUJFJoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:44:38 -0400
Date: Wed, 6 Oct 2004 11:44:37 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
Message-ID: <20041006094437.GA28277@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, mingo@redhat.com,
	linux-kernel@vger.kernel.org, judith@osdl.org
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005233958.522972a9.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 11:39:58PM -0700, Andrew Morton wrote:

> I agree - -mm breaks too often.  You wouldn't believe the crap people throw
> at me :(.   But a lot of problems get fixed this way too.

Mainline is suffering too - lots of people I know running 2.6 on production
systems have noted a marked increase in problems, crashes, odd things. 

I'd bet you get a lot of people who'd vote for a timeout right now to figure
out what's going wrong.

There is the distinct impression that we are going down hill in this series.
My personal feeling is that this trend started almost immediately after OLS.

I can try to gather the general reports I hear from people - it might well
be that we are not reporting the bugs properly. I'm sitting on a couple of
odd things myself that need to be written up.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
