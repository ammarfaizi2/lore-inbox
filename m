Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVDMBB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVDMBB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVDMA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 20:59:10 -0400
Received: from verein.lst.de ([213.95.11.210]:63410 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262141AbVDLUOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:14:53 -0400
Date: Tue, 12 Apr 2005 22:14:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
Message-ID: <20050412201433.GA25869@lst.de>
References: <1113282436.21548.42.camel@gaston> <jell7nu6yk.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jell7nu6yk.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 09:32:19PM +0200, Andreas Schwab wrote:
> On my PowerMac the internal speaker is now working, but unfortunately on
> the line-out I get nearly no output.  I have pushed both the master and
> pcm control to the maximum and still barely hear anything.

Work fine for me, but I had to turn the volume to the max on the
external amplifier, so this is probably the same problem.

