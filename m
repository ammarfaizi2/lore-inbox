Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUENLPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUENLPg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUENLPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:15:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62012 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265250AbUENLPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:15:34 -0400
Date: Fri, 14 May 2004 04:14:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: raghav@in.ibm.com, akpm@osdl.org, maneesh@in.ibm.com, dipankar@in.ibm.com,
       torvalds@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040514041433.1b38b120.pj@sgi.com>
In-Reply-To: <20040514110427.GG17326@suse.de>
References: <20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<20040508201259.GA6383@in.ibm.com>
	<20041006125824.GE2004@in.ibm.com>
	<20040511132205.4b55292a.akpm@osdl.org>
	<20040514103322.GA6474@in.ibm.com>
	<20040514035039.347871e8.pj@sgi.com>
	<20040514110427.GG17326@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so I guess you do.

Sorry - I'm being thick.

Is the new hashing good or bad?

(Usually, performance is thought of as something 'good', so when you say
it is 'brought down', that sounds 'bad', but since it's ms/iteration,
I'm guessing that you mean to say that the ms/iteration is lower, which
would I guess improves performance, so I'm guessing that bringing
performance down is 'good' in this case, which is not idiomatic to the
particular version of English I happen to speak ...  So please favor
this poor old brain of mine and state outright whether the new hash is
good or bad.  Does the new hash makes performance better or worse?)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
