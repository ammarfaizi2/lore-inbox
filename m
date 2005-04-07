Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVDGJt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVDGJt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDGJt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:49:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:19368 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262408AbVDGJt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:49:28 -0400
Date: Thu, 7 Apr 2005 02:49:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050407024912.1c8c445b.akpm@osdl.org>
In-Reply-To: <1112865919.24487.442.camel@hades.cambridge.redhat.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<1112858331.6924.17.camel@localhost.localdomain>
	<20050407015019.4563afe0.akpm@osdl.org>
	<1112865919.24487.442.camel@hades.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2005-04-07 at 01:50 -0700, Andrew Morton wrote:
> > (I don't do that for -mm because -mm basically doesn't work for 99% of
> > the time.  Takes 4-5 hours to out a release out assuming that
> > nothing's busted, and usually something is).
> 
> On the subject of -mm: are you going to keep doing the BK imports to
> that for the time being, or would it be better to leave the BK trees
> alone now and send you individual patches.

I really don't know - I'll continue to pull the bk trees for a while, until
we work out what the new (probably interim) regime looks like.

> For that matter, will there be a brief amnesty after 2.6.12 where Linus
> will use BK to pull those trees which were waiting for that, or will we
> all need to export from BK manually?
> 

I think Linus has stopped using bk already.

