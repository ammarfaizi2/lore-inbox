Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267398AbSLER4k>; Thu, 5 Dec 2002 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbSLER4j>; Thu, 5 Dec 2002 12:56:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25360 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267398AbSLER4f>;
	Thu, 5 Dec 2002 12:56:35 -0500
Date: Thu, 5 Dec 2002 10:03:58 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205180357.GB3712@kroah.com>
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com> <20021205163300.GC2865@kroah.com> <20021205163339.GD2865@kroah.com> <20021205163406.GE2865@kroah.com> <20021205163541.GF2865@kroah.com> <20021205170002.A30875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205170002.A30875@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 05:00:02PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 05, 2002 at 08:35:42AM -0800, Greg KH wrote:
> > ChangeSet 1.797.142.4, 2002/12/04 16:56:51-06:00, greg@kroah.com
> > 
> > LSM: add the example rootplug module
> 
> I don't think that's the kind of module that should be merged..

Why?  We have other "example" drivers in the kernel tree.  This is just
like that.

thanks,

greg k-h
