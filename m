Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266789AbUFRUMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266789AbUFRUMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUFRULZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:11:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266789AbUFRUDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:03:42 -0400
Date: Fri, 18 Jun 2004 16:03:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040618153350.GB20632@lug-owl.de>
Message-ID: <Pine.LNX.4.44.0406181600310.8065-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 08:13:15 -0700, William Lee Irwin III <wli@holomorphy.com>

> > The shame of things is that the economic/effort problem appears to
> > often be "solved" by never migrating to new kernel versions, ...

> Unfortunately, you're *very* right on this. Eg. read the linux-mips list
> (at linux-mips.org). You'll see that this list is often hit by people
> having problems. Normally, they hack on kernels like 2.4.16 or the like.

And they have problems for which fixes were merged into the
upstream kernel well over a year ago.

If these developers had just merged their own stuff into the
upstream kernel, they wouldn't have had to deal with all the
ancient kernel bugs - the community has solved them already
and the embedded developers could just inherit those fixes
from upstream.

In short, the work of merging your functionality back upstream 
is a way to reduce the total amount of work that needs to be done.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

