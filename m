Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVBODkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVBODkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVBODkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:40:10 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:39599 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261615AbVBODjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:39:52 -0500
Subject: Re: [BK] upgrade will be needed
From: Steven Rostedt <rostedt@goodmis.org>
To: Larry McVoy <lm@bitmover.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215030145.GB6288@bitmover.com>
References: <20050214174932.GB8846@bitmover.com>
	 <1108406835.8413.20.camel@localhost.localdomain>
	 <20050214190137.GB16029@bitmover.com>
	 <1108415541.8413.48.camel@localhost.localdomain>
	 <20050214231148.GP13174@bitmover.com>
	 <1108425420.8413.78.camel@localhost.localdomain>
	 <20050215000028.GS13174@bitmover.com>
	 <1108426451.8413.84.camel@localhost.localdomain>
	 <20050215003535.GB32158@bitmover.com>
	 <1108429259.8413.99.camel@localhost.localdomain>
	 <20050215030145.GB6288@bitmover.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 14 Feb 2005 22:39:44 -0500
Message-Id: <1108438784.8413.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 19:01 -0800, Larry McVoy wrote:

> Would the tarball + patch server suffice for you?  We could make a
> ChangeSet file which had bk changes -v output in it and that would 
> give you a fairly useful set of version information.  For those who
> don't know, bk changes -v is output in time sorted order of changesets
> with the changeset comments then each file's comments like the output
> below.  
> 

This is perfect for me. The only time I've ever used BK was when someone
told me that I needed the lastest snapshot from the bk-tree.  What I do
with the kernel is to port it, write drivers or customize it for
customers. So I'm not in the development part of the kernel (although
I'll report bugs and fixes when I find them). I really believe that the
majority that download the kernel from BK are doing things like I am and
not part of the core development team. 

Currently, I'm working on a customization of Ingo's RT version, so
really at the moment I don't even need access to BK. But with my
previous job, I was downloading the bk version quite a lot. But just to
get the latest updates. So what you have suggested would have been all
that I needed.  As I've mentioned, earlier. I work from job to job and
my needs change with each one. I joined in this discussion because it
could have affected me quite a bit, since someday I might be hired to
work on a SCM tool, and I'm very careful about NDAs and the like.
 
-- Steve

PS - I'm packing up now to drive to Boston. See everyone at
LinuxWorld ;-)



