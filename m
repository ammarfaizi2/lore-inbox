Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934305AbWKUFIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934305AbWKUFIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966898AbWKUFIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:08:45 -0500
Received: from 1wt.eu ([62.212.114.60]:22789 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S934305AbWKUFIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:08:45 -0500
Date: Tue, 21 Nov 2006 06:08:37 +0100
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix "&& 0x03" obvious typo in net1080
Message-ID: <20061121050836.GA803@1wt.eu>
References: <20061119143301.GA2633@1wt.eu> <200611201852.20407.david-b@pacbell.net> <20061121042925.GA8399@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121042925.GA8399@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 08:29:25PM -0800, Greg KH wrote:
> On Mon, Nov 20, 2006 at 06:52:19PM -0800, David Brownell wrote:
> > On Sunday 19 November 2006 6:33 am, Willy Tarreau wrote:
> > > Hi David,
> > > 
> > > I found this bug while grepping for "&& 0x" in drivers.
> > > Care to forward upstream ?
> > 
> > I thought this already _was_ upstream ... Greg?
> 
> It's in my tree, and in the next -mm.  I didn't send it to Linus for
> 2.6.19, as it's only a debug issue, like you mentioned.
> 
> So it's in the pipeline...

OK, that explains why I did not find it fixed first :-)

Thanks guys,
Willy

