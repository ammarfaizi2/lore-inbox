Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVIUTpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVIUTpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVIUTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:45:51 -0400
Received: from gold.veritas.com ([143.127.12.110]:45884 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751406AbVIUTpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:45:50 -0400
Date: Wed, 21 Sep 2005 20:45:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Alexander Nyberg <alexn@telia.com>, torvalds@osdl.org, pavel@suse.cz,
       ebiederm@xmission.com, len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
In-Reply-To: <20050921111523.4b007281.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509212042400.11126@goblin.wat.veritas.com>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
 <20050921101855.GD25297@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
 <20050921173630.GA2477@localhost.localdomain> <20050921111523.4b007281.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 19:45:49.0795 (UTC) FILETIME=[115BE330:01C5BEE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Andrew Morton wrote:
> 
> I wouldn't say that bugmeister is a fulltime job, but it'll be a
> lot-of-time job.  It needs someone who isn't shy and who has a good
> understanding of the kernel code-wise, of the processes (hah) and of the
> people.
> 
> The ability to maintain an overall view of where we're at, which bugs are
> serious and which aren't.  The ability to succinctly communicate that
> overview to everyone else.  Able to tell Linus "you can't release a kernel
> until bugs A, B and C are fixed".  The skills and gut-feel to know when a
> patch is some once-off which can be ignored unless it reoccurs, etc.  It's
> one of those things which can consume as much effort as one is able to put
> into it.

I recognize this description: sorry, Andrew, can we please clone you?

Hugh
