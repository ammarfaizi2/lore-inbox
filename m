Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUIWJKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUIWJKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUIWJKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:10:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47328 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268339AbUIWJKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:10:33 -0400
Date: Thu, 23 Sep 2004 02:09:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: locking
Message-Id: <20040923020932.5a35fb41.pj@sgi.com>
In-Reply-To: <1095881907.5090.60.camel@betsy.boston.ximian.com>
References: <1095881861.5090.59.camel@betsy.boston.ximian.com>
	<1095881907.5090.60.camel@betsy.boston.ximian.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Evolution needs a heuristic to detect when I say that I attached
> something, but when in reality I did not.

I've mostly stopped submitting patches using my email client, and
instead submit them using a variant of a 'patch bomb' script.  This has
significantly improved the clerical accuracy of my patch submissions.

The variant I'm using is in pretty good shape - you're welcome to
give it a try.  See the embedded Usage string for documentation.

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

It handles sending one or several related patches, to a list of email
addresses.  You prepare a text directive file with the addresses,
subjects and pathnames to the files containing the message contents.
Then you send it all off with a single invocation of this 'sendpatchset'
script.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
