Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWADGwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWADGwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 01:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWADGwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 01:52:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751575AbWADGwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 01:52:22 -0500
Date: Tue, 3 Jan 2006 22:51:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mika Kukkonen <mikukkon@iki.fi>
Cc: laforge@netfilter.org, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: +
 netfilter-fix-handling-of-module-param-dcc_timeout-in-ip_conntrack_ircc.patch
 added to -mm tree
Message-Id: <20060103225157.0d03d726.akpm@osdl.org>
In-Reply-To: <4301cff60601032236h6c930d16j349bcb209d59b68b@mail.gmail.com>
References: <200601040603.k0463JZa012473@shell0.pdx.osdl.net>
	<4301cff60601032236h6c930d16j349bcb209d59b68b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Kukkonen <mikukkon@iki.fi> wrote:
>
> On 1/4/06, akpm@osdl.org <akpm@osdl.org> wrote:
> >
> > The patch titled
> >
> >      NETFILTER: Fix handling of module param dcc_timeout in ip_conntrack_irc.c
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      netfilter-fix-handling-of-module-param-dcc_timeout-in-ip_conntrack_ircc.patch
> 
> Umm.. Patrick McHardy actually posted a larger patch that incorporated this one,
> so you might actually want to drop this and pick that. See:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113522437714943&w=2

That was a couple of weeks ago and Patrick's patch hasn't yet made it to
any of the git trees which I know about.

Has Patrick's patch got lost, or is there some tree which I don't know
about, or what?

