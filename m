Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVB1VpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVB1VpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVB1VpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:45:22 -0500
Received: from galileo.bork.org ([134.117.69.57]:22681 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261768AbVB1VpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:45:00 -0500
Date: Mon, 28 Feb 2005 16:44:58 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perthread_pages_alloc cleanup
Message-ID: <20050228214458.GY26705@localhost>
References: <20050228155248.GR26705@localhost> <20050228213509.GB18162@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228213509.GB18162@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Feb 28, 2005 at 09:35:09PM +0000, Christoph Hellwig wrote:
> On Mon, Feb 28, 2005 at 10:52:48AM -0500, Martin Hicks wrote:
> > 
> > Hi Andrew,
> > 
> > This is just a cleanup - no functional changes.  Gets a bunch of code
> > outside an if by returning NULL earlier.
> 
> the last discussion of that code had the outcome we should just drop
> it, probably not worth wasting any time on it.

Fair enough.  I have no idea with regards to the merit of this code.
That detail just bugged me enough to send a patch.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
