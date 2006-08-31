Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWHaQkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWHaQkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWHaQkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:40:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932229AbWHaQkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:40:35 -0400
Date: Thu, 31 Aug 2006 09:40:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: mingo@elte.hu, ak@muc.de, pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: - i386-early-fault-handler.patch removed from -mm tree
Message-Id: <20060831094014.e2bbe610.akpm@osdl.org>
In-Reply-To: <200608311221_MC3-1-C9EE-3549@compuserve.com>
References: <200608311221_MC3-1-C9EE-3549@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 12:17:15 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <200608310422.k7V4M8Xu023875@shell0.pdx.osdl.net>
> 
> On Wed, 30 Aug 2006 21:22:08 -0700, Andrew Morton wrote:
> 
> > The patch titled
> > 
> >      i386: early fault handler
> > 
> > has been removed from the -mm tree.  Its filename is
> > 
> >      i386-early-fault-handler.patch
> > 
> > This patch was dropped because a different version got merged by andi
> 
> <*sigh*>
> 
> Didn't anyone even notice the fix that was already in -mm?

I sure did ;)

>  Now we're back
> to "guess which fault it was" when an early fault occurs.

please send fix.
