Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWCICog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWCICog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWCICog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:44:36 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:49956 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1160998AbWCICof convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:44:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GaK0aIizhcnOQzRKhscRd4nfmwUQw8XbK7KS1M+FmkXmK9rjlreswE2ZMr3JpthE9CyPG4u7j2BICglLQRS8bRoq22D64yrBCNCvBlrIsQDBKdNkRJf7NMG7G1VYPIWucVJt9MUQmwIAmcGB6Wj32kw6lqXOLg1X4TAX44XX/rk=
Message-ID: <35fb2e590603081844t4c5f062bo7f53088e3085a2a4@mail.gmail.com>
Date: Thu, 9 Mar 2006 02:44:34 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [OT] inotify hack for locate
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Chris Ball" <cjb@mrao.cam.ac.uk>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0603070524020.9699@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
	 <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
	 <440C0175.7040909@aitel.hist.no> <1141690310.25487.97.camel@mindpipe>
	 <35fb2e590603061633w2dd7fff4m63e73ee8ed409951@mail.gmail.com>
	 <Pine.LNX.4.58.0603070524020.9699@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, this could also be very useful for change management systems and
> especially backup utilities. Imagine having a daemon that records all the
> changes on a filesystem, and then backs them up periodically. Could very
> well be useful.

Some people have already done similar things with FUSE based
filesystems but my point is that there's nothing cool and useful in
mainline to do what I personally want :-) Anyway, I was catching up
with an old friend as part of this thread and we'll spend some time
over at LinuxWorld Boston hacking on some ideas. Then I'll see what's
worth doing.

Jon.
