Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269177AbUJFOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269177AbUJFOBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJFOBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:01:08 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:43269 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S269177AbUJFOBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:01:05 -0400
Date: Wed, 6 Oct 2004 16:00:59 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
Message-ID: <20041006140059.GA5298@pclin040.win.tue.nl>
References: <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au> <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au> <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org> <20041006094437.GA28277@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006094437.GA28277@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 11:44:37AM +0200, bert hubert wrote:

> Mainline is suffering too - lots of people I know running 2.6 on production
> systems have noted a marked increase in problems, crashes, odd things. 
> 
> I'd bet you get a lot of people who'd vote for a timeout right now to figure
> out what's going wrong.
> 
> There is the distinct impression that we are going down hill in this series.
> My personal feeling is that this trend started almost immediately after OLS.

Well, suppose we eliminate 5% of all bugs each week.
Then after a year only 7% of the original bugs are left.

In a stable series that is a fairly good result.
In a series that is simultaneously "stable" and "development"
new random bugs are being introduced continually.
One never reaches the state with only few bugs.
