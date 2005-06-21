Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVFUT7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVFUT7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVFUT5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:57:17 -0400
Received: from mail.suse.de ([195.135.220.2]:42173 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262281AbVFUT4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:56:44 -0400
Date: Tue, 21 Jun 2005 21:56:43 +0200
From: Andi Kleen <ak@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@suse.de>, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621195642.GD14251@wotan.suse.de>
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B86027.3090001@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:44:55AM -0700, Hans Reiser wrote:
> vs and zam, please comment on what we get from our profiler and spinlock
> debugger that the standard tools don't supply.  I am sure you have a
> reason, but now is the time to articulate it.
> 
> We would like to keep the disabled code in there until we have a chance
> to prove (or fail to prove) that cycle detection can be resolved
> effectively, and then with a solution in hand argue its merits.

How about the review of your code base? Has reiser4 ever been
fully reviewed by people outside your group? 

Normally full review is a requirement for merging.

-Andi
