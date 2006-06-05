Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750964AbWFELBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWFELBH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFELBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:01:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36655 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750964AbWFELBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:01:06 -0400
Date: Mon, 5 Jun 2006 13:03:31 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: header cleanup and install
Message-ID: <20060605110331.GE4400@suse.de>
References: <20060604135011.decdc7c9.akpm@osdl.org> <1149456793.30024.21.camel@pmac.infradead.org> <20060605105240.GB4400@suse.de> <1149504858.30024.68.camel@pmac.infradead.org> <20060605105925.GD4400@suse.de> <1149505074.30024.70.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149505074.30024.70.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2006, David Woodhouse wrote:
> On Mon, 2006-06-05 at 12:59 +0200, Jens Axboe wrote:
> > Yeah I'm just kidding, I just noticed that your British fingers could
> > not leave the "color" alone! The patches are fine with me, rb usage is
> > quite wide spread and shrinking the nodes is definitely a good thing.
> 
> Hey... I left rb_insert_color() as it was, didn't I? :)

You did - and snuck in the renaming in the headers :-)
But don't label me as a colour racist.

-- 
Jens Axboe

