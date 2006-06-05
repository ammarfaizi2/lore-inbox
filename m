Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750833AbWFEJLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWFEJLD (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 05:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWFEJLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 05:11:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbWFEJLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 05:11:01 -0400
Date: Mon, 5 Jun 2006 02:10:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
Message-Id: <20060605021054.4d5428da.akpm@osdl.org>
In-Reply-To: <20060605085918.GB26766@infradead.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605013223.GD17361@havoc.gtf.org>
	<20060604184711.0a328d18.akpm@osdl.org>
	<20060605085918.GB26766@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 09:59:18 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Sun, Jun 04, 2006 at 06:47:11PM -0700, Andrew Morton wrote:
> > Yes, I agree.  As long as we reasonably think that a piece of code *will*
> > become acceptable within a reasonable amount of time then going early is
> > safe.
> 
> 
> Definitly not the case for areca.  The only progress at all is where people
> like Arjan, Randy or me did very intensive babysitting.  And it's still far
> from beeing there.
> 
> And especially in scsi land I'm absolutely against putting in more substandard
> drivers.  The subsystem is still badly plagued from lots of old drivers that
> aren't up to any standards, and we need to decrease the maintaince load due
> to odd drivers not increase it even further.

So..  How are we going to get the Areca controllers supported in Linux? 
The code's been sitting in -mm for over a year and the vendor does have
staff assigned to work on it.
