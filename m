Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbVIVNYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbVIVNYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIVNYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:24:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52781 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030326AbVIVNYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:24:50 -0400
Date: Thu, 22 Sep 2005 15:24:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922132451.GI4262@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <20050922061849.GJ7929@suse.de> <4332ABDC.3030106@rtr.ca> <E1EIQoQ-0007FT-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EIQoQ-0007FT-00@chiark.greenend.org.uk>
X-IMAPbase: 1124875140 49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22 2005, Matthew Garrett wrote:
> Mark Lord <liml@rtr.ca> wrote:
> 
> > Rather than sitting around for another six months hoping the problem
> > will go away (it won't), perhaps we should just update/merge Jen's
> > patch as a sorely needed interim fix.
> 
> As a datapoint, we've been shipping it in Ubuntu for a month or so now
> and we haven't had any reported problems.

(dunno why I was trimmed from the reply?)

SUSE has shipped it in 9.3 and now in 10.0 as well.

-- 
Jens Axboe

