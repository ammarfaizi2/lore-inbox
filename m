Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269913AbUJMXN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbUJMXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbUJMXN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:13:28 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:51261 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269910AbUJMXMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:12:05 -0400
Message-ID: <35fb2e590410131612c3ee333@mail.gmail.com>
Date: Thu, 14 Oct 2004 00:12:04 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Diwaker Gupta <diwakergupta@gmail.com>
Subject: Re: Hierarchical schedulers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1b0b45570410131407127df0b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1b0b45570410131407127df0b3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004 14:07:31 -0700, Diwaker Gupta
<diwakergupta@gmail.com> wrote:

> Are there any efforts underway (apart from CKRM -- ckrm.sf.net) to
> provide hierarchical schedulers

In terms of what you're talking about (unified scheduling of various
different resources in to groups), not as far as I'm aware. There are
existing ways of layering things like regular process scheduling in to
groups (scheduling domains, and other similar examples) but what
you're after is different. Someone will doubtlessly crawl out of the
woodwork with examples which do what you want though :-)

Jon.
