Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWDZTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWDZTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWDZTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 15:20:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750737AbWDZTU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 15:20:27 -0400
Date: Wed, 26 Apr 2006 21:21:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060426192106.GB9211@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <20060426182323.GI5002@suse.de> <20060426114649.5a0e0dea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426114649.5a0e0dea.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > Are there cases where the lockless page cache performs worse than the
> > current one?
> 
> Yeah - when human beings try to understand and maintain it.
> 
> The usual tradeoffs apply ;)

Ah ok, thanks for clearing that up :-)

-- 
Jens Axboe

