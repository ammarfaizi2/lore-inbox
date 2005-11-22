Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVKVIG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVKVIG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVKVIG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:06:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964832AbVKVIG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:06:29 -0500
Date: Tue, 22 Nov 2005 00:06:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [patch 0/12] mm: optimisations
Message-Id: <20051122000620.4cad7ce6.akpm@osdl.org>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> The following patchset against 2.6.15-rc2 contains optimisations to the
>  mm subsystem, mainly the page allocator.

All look sane to me - I merged the ones which applied, randomly dropped the
rest - there are still a large number of mm/ changes pending.  A number of
which don't generate a lot of enthusiasm, frankly.
