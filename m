Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUIAXoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUIAXoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUIAXl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:41:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:57984 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268179AbUIAX0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:26:03 -0400
Date: Wed, 1 Sep 2004 16:25:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, jh@sgi.com, limin@engr.sgi.com,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, erikj@sgi.com
Subject: Re: [PATCH] improving JOB kernel/user interface
Message-ID: <20040901162543.J1924@build.pdx.osdl.net>
References: <4134FE16.2000308@engr.sgi.com> <20040901193829.GJ5886@sgi.com> <20040901130623.F1924@build.pdx.osdl.net> <20040901160127.3ee02f0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040901160127.3ee02f0b.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 01, 2004 at 04:01:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> > But that system call would still be a single mutliplexor for many calls, right?
> 
> Either that, or 19 separate syscalls...

Heh, you snipped out the part where I (obtusely) said that ;-)

> > Not ideal.  Have you tried to map to an fs?
> 
> That's worth investigation.

Limin and I are checking it out.

thanks,
-chris
