Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWF3BFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWF3BFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWF3BFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:05:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWF3BFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:05:43 -0400
Date: Thu, 29 Jun 2006 18:07:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-Id: <20060629180706.64a58f95.akpm@osdl.org>
In-Reply-To: <1151628246.22380.58.camel@mindpipe>
References: <20060629192121.GC19712@stusta.de>
	<1151628246.22380.58.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Thu, 2006-06-29 at 21:21 +0200, Adrian Bunk wrote:
> > This patch was already sent on:
> > - 26 Jun 2006
> > - 27 Apr 2006
> > - 19 Apr 2006
> > - 11 Apr 2006
> > - 10 Mar 2006
> > - 29 Jan 2006
> > - 21 Jan 2006 
> 
> 3 days ago?  That seems a bit silly.  Why didn't you just ping Andrew on
> it?
> 
> Andrew, what's the status of this?  Can we get an ACK or a NACK before
> this starts getting reposted every day? ;-)
> 

I am stolidly letting the arch maintainers and the developer of this
feature work out what to do.
