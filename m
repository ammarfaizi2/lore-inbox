Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbUCPItP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263560AbUCPItO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:49:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41870 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263511AbUCPItO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:49:14 -0500
Date: Tue, 16 Mar 2004 08:38:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       jbarnes@sgi.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040316073850.GE5320@suse.de>
References: <20040316052256.GA647970@sgi.com> <4056A062.6040203@cyberone.com.au> <20040316072046.GA636090@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316072046.GA636090@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15 2004, Jeremy Higdon wrote:
> > I wonder why nobody's complained about this before?
> 
> Well, some of us have, but probably not very loudly.  I had
> naively believed that the global unplug was gone in 2.6.

Ditching plugging at the water cooler doesn't count as complain, it
needs to get out in the open :-). When Intel posted their patch and
numbers, that was the first I heard of it.

-- 
Jens Axboe

