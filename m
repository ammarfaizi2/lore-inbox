Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265254AbUENL1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUENL1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENL1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:27:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17375 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265257AbUENL1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:27:20 -0400
Date: Fri, 14 May 2004 16:54:08 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Jens Axboe <axboe@suse.de>, raghav@in.ibm.com, akpm@osdl.org,
       maneesh@in.ibm.com, torvalds@osdl.org, manfred@colorfullife.com,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040514112408.GM4002@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com> <20040511132205.4b55292a.akpm@osdl.org> <20040514103322.GA6474@in.ibm.com> <20040514035039.347871e8.pj@sgi.com> <20040514110427.GG17326@suse.de> <20040514041433.1b38b120.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514041433.1b38b120.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:14:33AM -0700, Paul Jackson wrote:
> > so I guess you do.
> 
> Sorry - I'm being thick.
> 
> Is the new hashing good or bad?

That I don't know from the contradicting descriptions, but...

> (Usually, performance is thought of as something 'good', so when you say
> it is 'brought down', that sounds 'bad', but since it's ms/iteration,
> I'm guessing that you mean to say that the ms/iteration is lower, which
> would I guess improves performance, so I'm guessing that bringing
> performance down is 'good' in this case, which is not idiomatic to the
> particular version of English I happen to speak ...  So please favor

In this case, the performance is inversely proportional to the
benchmark metric. Lower benchmark metric means better performance.

Thanks
Dipankar
