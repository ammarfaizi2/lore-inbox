Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUGAWoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUGAWoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUGAWoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:44:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:13037 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266358AbUGAWnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:43:13 -0400
Date: Thu, 1 Jul 2004 15:45:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mpm@selenic.com, paul@linuxaudiosystems.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-Id: <20040701154554.30063e97.akpm@osdl.org>
In-Reply-To: <20040701181401.GB21066@holomorphy.com>
References: <200406301341.i5UDfkKX010518@localhost.localdomain>
	<20040701180356.GI5414@waste.org>
	<20040701181401.GB21066@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Jul 01, 2004 at 01:03:56PM -0500, Matt Mackall wrote:
> > I'm afraid these "brave souls" have shown up to the baby shower after
> > the child's been accepted to college. Developers getting around to
> > testing 2.6 after multiple vendors are shipping it should not be
> > characterized as courageous.
> 
> I appear to have nuked the thread you're replying to in disgust over
> this precise issue.

In fairness, the CPU scheduler has been spinning like a top for a
couple of years, and it still ain't settled.

That's just the one in Linus's tree, let alone the umpteen rewrites which are
floating about.
