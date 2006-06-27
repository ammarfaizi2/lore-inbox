Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933096AbWF0JYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933096AbWF0JYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWF0JYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:24:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933096AbWF0JX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:23:58 -0400
Date: Tue, 27 Jun 2006 02:23:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, swhiteho@redhat.com, torvalds@osdl.org,
       teigland@redhat.com, pcaulfie@redhat.com, kanderso@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-Id: <20060627022335.8c238772.akpm@osdl.org>
In-Reply-To: <20060627090408.GA2382@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	<20060623144928.GA32694@infradead.org>
	<20060626200300.GA15424@elte.hu>
	<20060627063339.GA27938@elte.hu>
	<20060627000633.91e06155.akpm@osdl.org>
	<20060627083544.GA32761@elte.hu>
	<20060627015005.21c20186.akpm@osdl.org>
	<20060627090408.GA2382@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 11:04:08 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > It's a general problem - our reviewing resources do not have the 
> > capacity to cover our coding resources.  This is especially the case 
> > on filesystems.  We'd have merged (a very different) reiser4 a year 
> > ago if things were in balance.
> 
> and just this very minute what gets merged upstream? A chunk of OCFS2 

oh yes, running a git tree is a wonderful way to avoid code review.

We ought to require that people get each diff onto a useful mailing list
for review before sending them upstream.  And not in batches of 100 five
minutes before sending the pull request.

oh, and we ought to require that people send patches upstream more than
fifteen minutes after they wrote them.

<starts to calm down>
