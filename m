Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUBXWav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUBXWau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:30:50 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:658 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262498AbUBXWat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:30:49 -0500
Date: Tue, 24 Feb 2004 17:29:16 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       <marcelo.tosatti@cyclades.com>, <torvalds@osdl.org>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
In-Reply-To: <20040224195745.GA777@kroah.com>
Message-ID: <Pine.LNX.4.44.0402241728460.21522-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Greg KH wrote:
> On Tue, Feb 24, 2004 at 07:50:18PM +0000, Christoph Hellwig wrote:

> > I don't understand why anyone is wasting time on this.  Without available
> > hardware drivers this huge midlayer is completely useless.
> 
> You mean this whole huge chunk of code doesn't have any hardware
> drivers?  What good is it then?

Beats me. I hope we can just bury this infiniband stuff
before we waste any more time on it.

I really can't see any reason why we would want to have
this.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

