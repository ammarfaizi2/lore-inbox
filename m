Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWAFOWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWAFOWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAFOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:22:20 -0500
Received: from verein.lst.de ([213.95.11.210]:50379 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751457AbWAFOWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:22:19 -0500
Date: Fri, 6 Jan 2006 15:21:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ric Wheeler <ric@emc.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, schwidefsky@de.ibm.com,
       arnd@arndb.de, linux-kernel@vger.kernel.org,
       "saparnis, carol" <saparnis_carol@emc.com>
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
Message-ID: <20060106142146.GA20094@lst.de>
References: <20051216143348.GB19541@lst.de> <20060106110157.GA16725@lst.de> <43BE7C45.4090206@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BE7C45.4090206@emc.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:18:45AM -0500, Ric Wheeler wrote:
> Christoph Hellwig wrote:
> 
> >So can we please put this into -mm now so it can go to Linus for 2.6.16
> >still?
> >
> >
> > 
> >
> If you could hold off just a couple of weeks, I hope that we can get 
> through our EMC process junk and get the GPL'ed patch out to fix the 
> symmetrix support part of this rolled in as well,

Why?  We never do things to support legally questionable binary modules.
And on the practical side, does emc even ship modules for -mm release?
What's the point of not putting it into -mm?
