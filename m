Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWIAOXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWIAOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:23:25 -0400
Received: from brick.kernel.dk ([62.242.22.158]:24644 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750812AbWIAOXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:23:25 -0400
Date: Fri, 1 Sep 2006 16:26:23 +0200
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: Adrian Bunk <bunk@stusta.de>, Grant Wilson <grant.wilson@zen.co.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: Re: [-mm patch] drivers/md/Kconfig: fix BLOCK dependency
Message-ID: <20060901142622.GE25434@kernel.dk>
References: <20060901135055.GA18276@stusta.de> <20060901015818.42767813.akpm@osdl.org> <44F80F0D.70100@zen.co.uk> <11281.1157120111@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11281.1157120111@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01 2006, David Howells wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > -if CONFIG_BLOCK
> > +if BLOCK
> 
> Oops.
> 
> Acked-By: David Howells <dhowells@redhat.com>

Merged.

-- 
Jens Axboe

