Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJLS35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJLS35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJLS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:29:46 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:43498 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267565AbUJLS3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:29:04 -0400
Date: Tue, 12 Oct 2004 20:29:42 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20041012182942.GA17849@dualathlon.random>
References: <20041012174605.GH17372@dualathlon.random> <Pine.LNX.4.44.0410121409160.13693-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410121409160.13693-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:10:52PM -0400, Rik van Riel wrote:
> On Tue, 12 Oct 2004, Andrea Arcangeli wrote:
> 
> > However as said boinc and seti would better start using it too.
> 
> Thinking about it some more, I'm not convinced they can.
> 
> After all, they need to get new data to perform calculations
> on, and pass the results of previous calculations on to the
> server.
> 
> In order to do that, the user needs to run code that's not
> restricted by seccomp. [..]

Getting new data to performance calculations and pass the results up to
the buyer is what I'm doing too and it's the ideal workload to use
with seccomp or trusted computing. But this is very offtopic discussion
for this list.

jpeg sure can be decompressed too.
