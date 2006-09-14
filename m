Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWINQAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWINQAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWINQAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:00:49 -0400
Received: from brick.kernel.dk ([62.242.22.158]:55368 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750922AbWINQAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:00:48 -0400
Date: Thu, 14 Sep 2006 17:59:00 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 10/11] LTTng-core 0.5.108 : relayfs
Message-ID: <20060914155900.GB5253@kernel.dk>
References: <20060914034940.GK2194@Krystal> <20060914075353.GE7425@kernel.dk> <20060914155427.GE29906@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914155427.GE29906@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14 2006, Mathieu Desnoyers wrote:
> * Jens Axboe (axboe@kernel.dk) wrote:
> > On Wed, Sep 13 2006, Mathieu Desnoyers wrote:
> > > 10 - Forward port of RelayFS 2.6.16 API, plus some enhancements.
> > > patch-2.6.17-lttng-core-0.5.108-relayfs.diff
> > 
> > One big question - why?!
> > 
> (repeated)
> It's a temporary solution only used because relayfs has been such a
> moving target lately that I decided to wait for things to settle down
> before switching. I plan to switch to the new relay.o and use DebugFS
> for filesystem.  I just haven't done the change yet.

Since going into the kernel, it's only changed once and that was 6
(something like that) months ago. So I'd say that your statement there
is hugely exaggerated. Just get it fixed up, if you are serious in any
way with posting your patches.

-- 
Jens Axboe

