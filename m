Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWF3Ccm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWF3Ccm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWF3Ccl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:32:41 -0400
Received: from xenotime.net ([66.160.160.81]:34758 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751417AbWF3Ccl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:32:41 -0400
Date: Thu, 29 Jun 2006 19:35:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-Id: <20060629193525.af983237.rdunlap@xenotime.net>
In-Reply-To: <20060629180706.64a58f95.akpm@osdl.org>
References: <20060629192121.GC19712@stusta.de>
	<1151628246.22380.58.camel@mindpipe>
	<20060629180706.64a58f95.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 18:07:06 -0700 Andrew Morton wrote:

> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Thu, 2006-06-29 at 21:21 +0200, Adrian Bunk wrote:
> > > This patch was already sent on:
> > > - 26 Jun 2006
> > > - 27 Apr 2006
> > > - 19 Apr 2006
> > > - 11 Apr 2006
> > > - 10 Mar 2006
> > > - 29 Jan 2006
> > > - 21 Jan 2006 
> > 
> > 3 days ago?  That seems a bit silly.  Why didn't you just ping Andrew on
> > it?
> > 
> > Andrew, what's the status of this?  Can we get an ACK or a NACK before
> > this starts getting reposted every day? ;-)
> > 
> 
> I am stolidly letting the arch maintainers and the developer of this
> feature work out what to do.

Bah, options that are not Required should default to n.
I support Adrian's patch.

---
~Randy
