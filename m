Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWFFMcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWFFMcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 08:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFFMcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 08:32:13 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:41921 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751314AbWFFMcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 08:32:12 -0400
Subject: Re: 2.6.18 -mm pi-futex merge
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 08:32:08 -0400
Message-Id: <1149597128.16247.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 13:50 -0700, Andrew Morton wrote:

> pi-futex-futex-code-cleanups.patch
> pi-futex-robust-futex-docs-fix.patch
> pi-futex-introduce-debug_check_no_locks_freed.patch
> pi-futex-introduce-warn_on_smp.patch
> pi-futex-add-plist-implementation.patch
> pi-futex-scheduler-support-for-pi.patch
> pi-futex-rt-mutex-core.patch
> pi-futex-rt-mutex-docs.patch
> pi-futex-rt-mutex-docs-update.patch
> pi-futex-rt-mutex-debug.patch
> pi-futex-rt-mutex-tester.patch
> pi-futex-rt-mutex-futex-api.patch
> pi-futex-futex_lock_pi-futex_unlock_pi-support.patch
> #
> futex_requeue-optimization.patch
> 
>  Priority-inheriting futexes.  I don't have a clue how this code works,
>  but it sure has a lot of trylocks for something which allegedly works. 
>  Will merge.

Andrew, I wrote the rt-mutex-design.txt just so you would have a clue :)

If you have any questions, I would be happy to update it to make it
clearer.

-- Steve


