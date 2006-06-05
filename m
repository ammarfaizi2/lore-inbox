Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751269AbWFESJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWFESJg (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFESJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:09:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWFESJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:09:35 -0400
Date: Mon, 5 Jun 2006 11:09:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: header cleanup and install
Message-Id: <20060605110928.35110000.akpm@osdl.org>
In-Reply-To: <20060605110331.GE4400@suse.de>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<1149456793.30024.21.camel@pmac.infradead.org>
	<20060605105240.GB4400@suse.de>
	<1149504858.30024.68.camel@pmac.infradead.org>
	<20060605105925.GD4400@suse.de>
	<1149505074.30024.70.camel@pmac.infradead.org>
	<20060605110331.GE4400@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 13:03:31 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Mon, Jun 05 2006, David Woodhouse wrote:
> > On Mon, 2006-06-05 at 12:59 +0200, Jens Axboe wrote:
> > > Yeah I'm just kidding, I just noticed that your British fingers could
> > > not leave the "color" alone! The patches are fine with me, rb usage is
> > > quite wide spread and shrinking the nodes is definitely a good thing.
> > 
> > Hey... I left rb_insert_color() as it was, didn't I? :)
> 
> You did - and snuck in the renaming in the headers :-)
> But don't label me as a colour racist.
> 

I'm not as shy.

David, we now have a mixture of "color" and "colour" in the same piece of
code.  That's just dumb.

