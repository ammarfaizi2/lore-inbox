Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVKUO3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVKUO3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVKUO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:29:43 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:46768 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932310AbVKUO3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:29:43 -0500
Date: Mon, 21 Nov 2005 06:29:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, akpm@osdl.org
Subject: Re: [patch 0/12] mm: optimisations
Message-Id: <20051121062937.7f1a11a7.pj@sgi.com>
In-Reply-To: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Welcome to sendpatchset - cool.

(Nick is now using sendpatchset:
    http://www.speakeasy.org/~pj99/sgi/sendpatchset
 to send these patches, so they are inline.)

Now ... if you use sendpatchset to send the entire set at once, and
(even fancier) number them "01/12" instead of "1/12", we will see these
patches in the order you numbered them, instead of in the order you
apparently sent them: 11, 7, 8, 9, 12, 4, 2, 1, 5, 10 (with 3 and 6
still outstanding).

Your single sendpatchset control file would include lines something
like:

    subj [patch 00/12] mm: optimisations
    file optimisations.txt

    subj [patch 01/12] mm: free_pages_and_swap_cache opt
    file patches/free_pages_and_swap_cache-opt

    subj [patch 02/12] mm: pagealloc opt
    file patches/pagealloc-opt

    subj [patch 03/12] mm: something-or-other
    file patches/something-or-other

    subj [patch 04/12] mm: set_page_refs opt
    file patches/set_page_refs-opt

    ...


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
