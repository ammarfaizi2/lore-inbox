Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTINP2A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 11:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTINP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 11:28:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59877 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261180AbTINP17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 11:27:59 -0400
Date: Sun, 14 Sep 2003 17:27:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030914152755.GA27105@suse.de>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913103014.GA7535@gamma.logic.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13 2003, Norbert Preining wrote:
> Hi Jens, hi list!
> 
> Will there be a new incantation of the laptop-mode patch for 2.4.23-pre4
> and up, which includes the aa fixes. I tried to patch it in, but the
> rejects in sysctl.h weren' solveable trivially.

Sure, I'll done a new patch in the next few days. I don't know what aa
patches you mean though? Are you trying to say that it conflicts with
the -aa series? It should be trivial to fix up, just renumber the
laptop-mode sysctls.

I'll send it to Marcelo too for 2.4.23.

-- 
Jens Axboe

