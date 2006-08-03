Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWHCTKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWHCTKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWHCTKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:10:40 -0400
Received: from ns1.suse.de ([195.135.220.2]:40329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030210AbWHCTKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:10:39 -0400
Date: Thu, 3 Aug 2006 12:06:05 -0700
From: Greg KH <greg@kroah.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060803190605.GB14237@kroah.com>
References: <44D1CC7D.4010600@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D1CC7D.4010600@vmware.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 03:14:21AM -0700, Zachary Amsden wrote:
> I would like to propose an interface for linking a GPL kernel, 
> specifically, Linux, against binary blobs.

Sorry, but we aren't lawyers here, we are programmers.  Do you have a
patch that shows what you are trying to describe here?  Care to post it?

How does this differ with the way that the Xen developers are proposing?
Why haven't you worked with them to find a solution that everyone likes?

And what about Rusty's proposal that is supposed to be the "middle
ground" between the two competing camps?  How does this differ from
that?  Why don't you like Rusty's proposal?

Please, start posting code and work together with the other people that
are wanting to achive the same end goal as you are.  That is what really
matters here.

thanks,

greg k-h
