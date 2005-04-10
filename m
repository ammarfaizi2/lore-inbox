Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDJTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDJTZu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDJTZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 15:25:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60300 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261584AbVDJTZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 15:25:45 -0400
Date: Sun, 10 Apr 2005 12:23:52 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Christopher Li <lkml@chrisli.org>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050410122352.19890f6d.pj@engr.sgi.com>
In-Reply-To: <20050410065307.GC13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	<20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050410065307.GC13853@64m.dyndns.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some thing like the following patch, may be turn off able.

Take out an old envelope and compute on it the odds of this
happening.

Say we have 10,000 kernel hackers, each producing one
new file every minute, for 100 hours a week.  And we've
cloned a small army of Andrew Morton's to integrate
the resulting tsunamai of patches.  And Linus is well
cared for in the state funny farm.

What is the probability that this check will fire even
once, between now and 10 billion years from now, when
the Sun has become a red giant destroying all life on
planet Earth?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
