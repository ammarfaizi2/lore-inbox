Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTJLUjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTJLUjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:39:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4484
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263525AbTJLUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:39:50 -0400
Date: Sun, 12 Oct 2003 22:40:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Matt_Domsch@Dell.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Message-ID: <20031012204016.GA1887@velociraptor.random>
References: <20031012143617.GS16013@velociraptor.random> <Pine.LNX.4.44.0310121319210.31175-100000@cluless.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310121319210.31175-100000@cluless.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 01:20:27PM -0400, Rik van Riel wrote:
> Agreed, the __free_pages_ok() change can almost certainly be
> undone and made more efficient.

ok great, many thanks for double checking.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
